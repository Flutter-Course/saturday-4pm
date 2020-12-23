import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:my_shop/models/customer.dart';
import 'package:my_shop/models/user.dart' as myApp;
import 'package:my_shop/models/vendor.dart';

class UserProvider with ChangeNotifier {
  myApp.User currentUser;
  Future<String> login(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return null;
    } catch (e) {
      switch (e.code) {
        case 'invalid-email':
          return 'Invalid email or password.';
        case 'wrong-password':
          return 'Invalid email or password.';
        case 'user-disabled':
          return 'This user has been disabled';
        default:
          return 'No user with this email address.';
      }
    }
  }

  Future<String> register(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      return null;
    } catch (e) {
      switch (e.code) {
        case 'email-already-in-use':
          return 'This email is already in use.';
        case 'invalid-email':
          return 'This email is invalid.';
        default:
          return 'Weak password.';
      }
    }
  }

  Future<String> resetPassword(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      return null;
    } catch (e) {
      return 'Error has occurred';
    }
  }

  Future<bool> completeUserProfile(
    File image,
    String userName,
    String mobileNumber,
    String address,
    LatLng position,
  ) async {
    try {
      String userId = FirebaseAuth.instance.currentUser.uid;
      String email = FirebaseAuth.instance.currentUser.email;

      final ref = FirebaseStorage.instance
          .ref('users/$userId.${image.path.split('.').last}');

      await ref.putFile(image);

      String url = await ref.getDownloadURL();
      await FirebaseFirestore.instance.collection('users').doc(userId).set(
        {
          'type': 'customer',
          'userName': userName,
          'email': email,
          'mobileNumber': mobileNumber,
          'address': address,
          'lat': position.latitude,
          'lng': position.longitude,
          'photoUrl': url,
        },
      );
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> switchAccountType() async {
    try {
      if (currentUser is Customer) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(currentUser.userId)
            .update({'type': 'vendor'});
        currentUser = Vendor.fromCustomer(currentUser);
      } else {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(currentUser.userId)
            .update({'type': 'customer'});
        currentUser = Customer.fromVendor(currentUser);
      }
      notifyListeners();
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  bool get isCustomer => currentUser is Customer;

  Future<bool> isProfileComplete() async {
    try {
      String userId = FirebaseAuth.instance.currentUser.uid;

      final document = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();
      if (document.exists) {
        if (document['type'] == 'customer') {
          currentUser = Customer.formFirestore(userId, document);
        } else {
          currentUser = Vendor.formFirestore(userId, document);
        }
        await currentUser.init();
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
