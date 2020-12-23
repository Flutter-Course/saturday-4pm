import 'package:google_maps_flutter/google_maps_flutter.dart';

abstract class User {
  String photoUrl, userName, userId, email, address, mobileNumber;
  LatLng positon;

  User.fromFirestore(this.userId, document)
      : this.email = document['email'],
        this.address = document['address'],
        this.mobileNumber = document['mobileNumber'],
        this.userName = document['userName'],
        this.photoUrl = document['photoUrl'],
        this.positon = LatLng(document['lat'], document['lng']);
  User.fromUser(User user)
      : this.address = user.address,
        this.email = user.email,
        this.mobileNumber = user.mobileNumber,
        this.photoUrl = user.photoUrl,
        this.positon = user.positon,
        this.userId = user.userId,
        this.userName = user.userName;
  Future<void> init();
}
