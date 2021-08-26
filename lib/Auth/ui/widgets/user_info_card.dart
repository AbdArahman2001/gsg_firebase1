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
              Container(
                child: FadeInImage(
                    placeholder:
                        ExactAssetImage('assets/images/placeHolder.png'),
                    image: NetworkImage(userModel.imageUrl)),
              ),
              SingleInfoRow('First Name: ', userModel.fName),
              SingleInfoRow('Last Name: ', userModel.lName),
              SingleInfoRow('E-mail: ', userModel.email),
              SingleInfoRow('Country: ', userModel.country),
              SingleInfoRow('City: ', userModel.city),
            ],
          ),
        ),
      ),
    );
  }
}

class SingleInfoRow extends StatelessWidget {
  final String field;
  final String value;
  SingleInfoRow(this.field, this.value);
  @override
  Widget build(BuildContext context) {
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
