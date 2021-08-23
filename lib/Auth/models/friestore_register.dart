import 'package:flutter/material.dart';

class FirestoreRegister {
  final String id;
  final String email;
  final String fName;
  final String lName;
  final String city;
  final String country;

  FirestoreRegister(
      {@required this.id,
      @required this.email,
      @required this.fName,
      @required this.lName,
      @required this.city,
      @required this.country});
  Map toMap() {
    return {
      'id': this.id,
      'email': this.email,
      'fName': this.fName,
      'lName': this.lName,
      'city': this.city,
      'country': this.country,
    };
  }
}
