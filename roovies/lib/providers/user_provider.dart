import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:roovies/models/firebase_handler.dart';
import 'package:roovies/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProvider with ChangeNotifier {
  User currentUser;

  Future<void> saveUserData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('idToken', currentUser.idToken);
    preferences.setString('refreshToken', currentUser.refreshToken);
    preferences.setString('email', currentUser.email);
    preferences.setString('userId', currentUser.userId);
    preferences.setString('expiryDate', currentUser.expiryDate.toString());
  }

  Future<void> removeUserData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.remove('idToken');
    preferences.remove('refreshToken');
    preferences.remove('email');
    preferences.remove('userId');
    preferences.remove('expiryDate');
  }

  Future<String> register(String email, String password) async {
    try {
      currentUser = await FirebaseHandler.instance.register(email, password);
      await saveUserData();
      return null;
    } on DioError catch (error) {
      String message = error.response.data['error']['message'];
      if (message == 'EMAIL_EXISTS') {
        return 'This email already exists.';
      } else {
        return 'Too many attampts please try again later';
      }
    }
  }

  Future<String> login(String email, String password) async {
    try {
      currentUser = await FirebaseHandler.instance.login(email, password);
      await saveUserData();
      return null;
    } on DioError catch (error) {
      String message = error.response.data['error']['message'];
      if (message == 'EMAIL_NOT_FOUND' || message == 'INVALID_PASSWORD') {
        return 'Wrong email or password.';
      } else {
        return 'This user has been disabled.';
      }
    }
  }

  Future<bool> isLoggedIn() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if (preferences.containsKey('idToken')) {
      currentUser = User.froPreferences(preferences);
      return true;
    } else {
      return false;
    }
  }

  Future<bool> refreshTokenIfNecessary() async {
    try {
      if (DateTime.now().isAfter(currentUser.expiryDate)) {
        currentUser = await FirebaseHandler.instance.refreshToken(currentUser);
        await saveUserData();
      }
      return true;
    } catch (error) {
      return false;
    }
  }
}
