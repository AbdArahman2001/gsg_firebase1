import 'package:flutter/material.dart';
import 'package:gsg_firebase1/Auth/helpers/auth_helper.dart';
import 'package:gsg_firebase1/Auth/helpers/router_helper.dart';
import 'dart:developer';

import 'package:gsg_firebase1/Auth/ui/widgets/custom_dialog.dart';
import 'package:gsg_firebase1/statics/statics.dart';

enum LoginState {
  signUp,
  signIn,
}

class AuthProvider extends ChangeNotifier {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  AuthHelper authHelper = AuthHelper.authHelper;
  String response = 'gg';
  LoginState loginState = LoginState.signUp;

  authenticate() async {
    loginState == LoginState.signUp ? await signUp() : await signIn();
  }

  Future<void> signUp() async {
    if (passwordController.text != confirmPasswordController.text) {
      CustomDialog.customDialog.showCustomDialog('No Match Password');
    } else {
      try {
        await authHelper.signUp(emailController.text, passwordController.text);
        sendVerificationEmail();
        resetControllers();
        switchLoginState();
      } catch (e) {
        CustomDialog.customDialog.showCustomDialog('Error when sign up: $e');
      }
    }
  }

  Future<void> signIn() async {
    await authHelper.signIn(emailController.text, passwordController.text);
    if (authHelper.checkEmailVerified()) {
      RouterHelper.router
          .goReplacementPage(Statics.statics.homePageScreenRoute);
      resetControllers();
      loginState = LoginState.signUp;
    } else
      CustomDialog.customDialog.showCustomDialog(
          'your email is not verified, press ok to send another verification email',
          sendVerificationEmail);
  }

  signOut() async {
    await authHelper.signOut();
    RouterHelper.router.goReplacementPage(Statics.statics.authScreenRoute);
  }

  switchLoginState() {
    if (loginState == LoginState.signUp)
      loginState = LoginState.signIn;
    else if (loginState == LoginState.signIn) loginState = LoginState.signUp;
    notifyListeners();
  }

  resetControllers() {
    emailController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
  }

  resetPassword() async {
    await authHelper.resetPassword(emailController.text);
  }

  sendVerificationEmail() async {
    await authHelper.sendVerificationEmail();
    await authHelper.signOut();
  }
}
