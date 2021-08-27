import 'package:flutter/material.dart';
import 'package:gsg_firebase1/Auth/providers/auth_provider.dart';
import 'package:gsg_firebase1/Auth/ui/widgets/user_info_card.dart';
import 'package:provider/provider.dart';

class UsersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Users'),
      ),
      body: Container(
        color: Colors.grey,
        child: Provider.of<AuthProvider>(context).users.length > 0
            ? Container(
                margin: EdgeInsets.symmetric(vertical: 24, horizontal: 12),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ...Provider.of<AuthProvider>(context)
                          .users
                          .map((userModel) => UserInfoCard(userModel))
                          .toList(),
                    ],
                  ),
                ),
              )
            : Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
