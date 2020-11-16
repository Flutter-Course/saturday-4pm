import 'package:shared_preferences/shared_preferences.dart';

class User {
  final String email, userId;
  String idToken, refreshToken;
  DateTime expiryDate;

  User.fromJson(dynamic json)
      : this.email = json['email'],
        this.userId = json['localId'],
        this.idToken = json['idToken'],
        this.refreshToken = json['refreshToken'],
        this.expiryDate =
            DateTime.now().add(Duration(seconds: int.parse(json['expiresIn'])));
  User.froPreferences(SharedPreferences preferences)
      : this.email = preferences.get('email'),
        this.userId = preferences.get('userId'),
        this.idToken = preferences.get('idToken'),
        this.refreshToken = preferences.get('refreshToken'),
        this.expiryDate = DateTime.parse(preferences.get('expiryDate'));
}
