import 'package:flutter/material.dart';

class CountryModel {
  final String id;
  final String name;
  final List cities;
  CountryModel({
    @required this.id,
    @required this.name,
    @required this.cities,
  });
  factory CountryModel.fromMap(Map map) {
    return CountryModel(
        id: map['id'], name: map['name'], cities: map['cities']);
  }
}
