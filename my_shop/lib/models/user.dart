import 'package:google_maps_flutter/google_maps_flutter.dart';

class User {
  String photoUrl, userName, userId, email, address, mobileNumber;
  LatLng positon;

  User.fromFirestore(this.userId, document)
      : this.email = document['email'],
        this.address = document['address'],
        this.mobileNumber = document['mobileNumber'],
        this.userName = document['userName'],
        this.photoUrl = document['photoUrl'],
        this.positon = LatLng(document['lat'], document['lng']);
}
