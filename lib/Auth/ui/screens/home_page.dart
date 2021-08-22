import 'package:flutter/material.dart';
import 'package:gsg_firebase1/Auth/providers/auth_provider.dart';
import 'package:gsg_firebase1/Auth/ui/widgets/custom_text_field.dart';
import 'package:provider/provider.dart';

class HomePageScreen extends StatelessWidget {
  HomePageScreen();

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(builder: (ctx, authProvider, _) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('HELLO\n${authProvider.emailController.text}'),
              ElevatedButton(
                  style: ButtonStyle(
                      padding: MaterialStateProperty.resolveWith(
                        (states) =>
                            EdgeInsets.symmetric(vertical: 4, horizontal: 24),
                      ),
                      shape: MaterialStateProperty.resolveWith((states) =>
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50)))),
                  onPressed: () {
                    authProvider.signOut();
                  },
                  child: Text('LOG OUT'))
            ],
          ),
        ),
      );
    });
  }
}
