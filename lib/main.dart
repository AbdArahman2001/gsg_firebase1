import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gsg_firebase1/Auth/helpers/router_helper.dart';
import 'package:gsg_firebase1/Auth/providers/auth_provider.dart';
import 'package:gsg_firebase1/Auth/ui/screens/auth_screen.dart';
import 'package:gsg_firebase1/Auth/ui/screens/edit_profile.dart';
import 'package:gsg_firebase1/Auth/ui/screens/home_page.dart';
import 'package:gsg_firebase1/Auth/ui/screens/splash_screen.dart';
import 'package:gsg_firebase1/statics/statics.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Statics statics = Statics.statics;
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AuthProvider>(
      create: (ctx) => AuthProvider(),
      builder: (ctx, _) {
        return MaterialApp(
          title: 'Firebase App',
          debugShowCheckedModeBanner: false,
          navigatorKey: RouterHelper.router.navKey,
          home: Scaffold(
            body: FutureBuilder(
                future: Firebase.initializeApp(),
                builder: (ctx, snapShot) {
                  if (snapShot.hasError) {
                    return Center(child: Text(snapShot.error.toString()));
                  }
                  if (snapShot.connectionState == ConnectionState.done) {
                    return CustomSplashScreen();
                  }
                  return Center(child: CircularProgressIndicator());
                }),
          ),
          routes: {
            statics.authScreenRoute: (ctx) => AuthScreen(),
            statics.homePageScreenRoute: (ctx) => HomePageScreen(),
            statics.editProfileRoute: (ctx) => EditProfile(),
          },
        );
      },
    );
  }
}
