import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:gsg_firebase1/Auth/providers/auth_provider.dart';
import 'package:provider/provider.dart';

class CustomTextField extends StatelessWidget {
  final String title;
  final TextEditingController controller;
  CustomTextField(this.controller, this.title);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: TextFormField(
        controller: this.controller,
        decoration: InputDecoration(
          labelText: title,
        ),
      ),
    );
  }
}
