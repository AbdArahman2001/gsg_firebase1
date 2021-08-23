import 'package:flutter/material.dart';
import 'package:gsg_firebase1/Auth/models/user_model.dart';

class UserInfoCard extends StatelessWidget {
  final UserModel userModel;
  UserInfoCard(this.userModel);
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        child: DefaultTextStyle(
          style: TextStyle(fontSize: 22, color: Colors.black),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              singleInfoRow('First Name: ', userModel.fName),
              singleInfoRow('Last Name: ', userModel.lName),
              singleInfoRow('E-mail: ', userModel.email),
              singleInfoRow('Country: ', userModel.country),
              singleInfoRow('City: ', userModel.city),
            ],
          ),
        ),
      ),
    );
  }

  Widget singleInfoRow(String field, String value) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          Text(
            field,
            style: TextStyle(fontSize: 22),
          ),
          Text(
            value,
            style: TextStyle(fontSize: 20, color: Colors.blue),
          ),
        ],
      ),
    );
  }
}
