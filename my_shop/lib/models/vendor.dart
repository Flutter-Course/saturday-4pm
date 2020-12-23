import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:my_shop/models/customer.dart';
import 'package:my_shop/models/product.dart';
import 'package:my_shop/models/user.dart';

class Vendor extends User {
  List<Product> products;
  Vendor.formFirestore(userId, document)
      : super.fromFirestore(userId, document);

  Vendor.fromCustomer(Customer customer) : super.fromUser(customer);

  Future<void> init() async {
    final queryData = await FirebaseFirestore.instance
        .collection('products')
        .where('vendorId', isEqualTo: this.userId)
        .get();
    if (queryData.docs.length != 0) {
      products = queryData.docs
          .map((document) => Product.fromDocumnet(document))
          .toList();
    } else {
      products = [];
    }
  }

  Future<List<String>> uploadImages(List<File> images) async {
    List<Reference> refs = images.map((image) {
      return FirebaseStorage.instance
          .ref('products/${this.userId}/${image.path.split('/').last}');
    }).toList();
    int index = 0;
    await Future.wait(refs.map((ref) {
      return ref.putFile(images[index++]);
    }).toList());

    return await Future.wait(refs.map((ref) {
      return ref.getDownloadURL();
    }).toList());
  }

  Future<bool> addProduct(
      String id,
      String title,
      String gender,
      String age,
      String category,
      String vendorId,
      String date,
      String description,
      double price,
      bool available,
      List<File> photos) async {
    try {
      List<String> photosUrls = await uploadImages(photos);
      await FirebaseFirestore.instance.collection('products').add({
        'id': id,
        'title': title,
        'gender': gender,
        'age': age,
        'category': category,
        'vendorId': vendorId,
        'date': date,
        'description': description,
        'price': price,
        'available': available,
        'photos': photosUrls
      });
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
