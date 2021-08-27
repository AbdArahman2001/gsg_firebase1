import 'package:flutter/material.dart';
import 'package:gsg_firebase1/Auth/models/user_model.dart';
import 'package:gsg_firebase1/Auth/ui/widgets/single_row_info.dart';

class UserInfoCard extends StatelessWidget {
  final UserModel userModel;

  UserInfoCard(this.userModel);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 8,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        child: DefaultTextStyle(
          style: TextStyle(fontSize: 22, color: Colors.black),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.all(12),
                child: CircleAvatar(
                  backgroundImage: NetworkImage(userModel.imageUrl),
                  radius: 80,
                ),
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
