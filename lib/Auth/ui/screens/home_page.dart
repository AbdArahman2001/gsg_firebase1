import 'package:flutter/material.dart';
import 'package:gsg_firebase1/Auth/providers/auth_provider.dart';
import 'package:gsg_firebase1/Auth/ui/widgets/custom_text_field.dart';
import 'package:gsg_firebase1/Auth/ui/widgets/user_info_card.dart';
import 'package:provider/provider.dart';

class HomePageScreen extends StatelessWidget {
  HomePageScreen();

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(builder: (ctx, authProvider, _) {
      return Scaffold(
        body: Container(
          margin: EdgeInsets.symmetric(vertical: 24, horizontal: 12),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ...authProvider.users
                    .map((userModel) => UserInfoCard(userModel))
                    .toList(),
              ],
            ),
          ),
        ),
        floatingActionButton: Container(
          alignment: Alignment.bottomCenter,
          child: ElevatedButton(
              style: ButtonStyle(
                  padding: MaterialStateProperty.resolveWith(
                    (states) =>
                        EdgeInsets.symmetric(vertical: 16, horizontal: 100),
                  ),
                  shape: MaterialStateProperty.resolveWith((states) =>
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50)))),
              onPressed: () {
                authProvider.signOut();
              },
              child: Text(
                'LOG OUT',
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              )),
        ),
      );
    });
  }
}
