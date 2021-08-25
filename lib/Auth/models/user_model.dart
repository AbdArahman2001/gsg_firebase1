import 'package:flutter/material.dart';

class UserModel {
  final String id;
  final String email;
  final String fName;
  final String lName;
  final String city;
  final String country;
  final String imageUrl;

  UserModel({
    @required this.id,
    @required this.email,
    @required this.fName,
    @required this.lName,
    @required this.city,
    @required this.country,
    @required this.imageUrl,
  });

  factory UserModel.fromMap(Map map) {
    return UserModel(
      id: map['id'],
      email: map['email'],
      fName: map['fName'],
      lName: map['lName'],
      city: map['city'],
      country: map['country'],
      imageUrl: map['imageUrl'],
    );
  }
}
