import 'package:flutter/material.dart';
import 'package:gsg_firebase1/Auth/providers/auth_provider.dart';
import 'package:gsg_firebase1/Auth/ui/screens/profile_screen.dart';
import 'package:gsg_firebase1/Auth/ui/screens/users_screen.dart';
import 'package:gsg_firebase1/Auth/ui/widgets/custom_text_field.dart';
import 'package:gsg_firebase1/Auth/ui/widgets/user_info_card.dart';
import 'package:provider/provider.dart';

class HomePageScreen extends StatelessWidget {
  HomePageScreen();

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(builder: (ctx, authProvider, _) {
      return DefaultTabController(
        length: 2,
        initialIndex: 1,
        child: Scaffold(
          body: TabBarView(
            children: [
              ProfileScreen(),
              UsersScreen(),
            ],
          ),
          /* floatingActionButton: Container(
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
          ),*/
        ),
      );
    });
  }
}
