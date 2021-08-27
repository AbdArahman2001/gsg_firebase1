import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gsg_firebase1/statics/statics.dart';

class CustomSplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 2)).then((_) async {
      if (FirebaseAuth.instance.currentUser == null ||
          FirebaseAuth.instance.currentUser.emailVerified == false) {
        Navigator.of(context)
            .pushReplacementNamed(Statics.statics.authScreenRoute);
      } else {
        Navigator.of(context)
            .pushReplacementNamed(Statics.statics.homePageScreenRoute);
      }
    });
    return Scaffold(
      backgroundColor: Colors.teal,
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
