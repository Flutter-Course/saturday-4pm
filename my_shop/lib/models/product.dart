import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  String _id, _title, _gender, _age, _category, _vendorId, _date, _description;
  double _price;
  bool _available;
  List<String> _photos;

  bool get available => this._available;

  String get id => this._id;

  String get description => this._description;

  String get title => this._title;

  String get gender => this._gender;

  String get age => this._age;

  String get category => this._category;

  String get vendorId => this._vendorId;

  String get date => this._date;

  double get price => this._price;

  List<String> get photos => this._photos;

  Product.fromDocumnet(QueryDocumentSnapshot document)
      : this._id = document.id,
        this._age = document.data()['age'],
        this._available = document.data()['available'],
        this._category = document.data()['category'],
        this._date = document.data()['date'],
        this._gender = document.data()['gender'],
        this._photos = document.data()['photos'],
        this._price = document.data()['price'],
        this._title = document.data()['title'],
        this._description = document.data()['description'];
}
