import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gsg_firebase1/Auth/helpers/auth_helper.dart';
import 'package:gsg_firebase1/Auth/helpers/fire_store_helper.dart';
import 'package:gsg_firebase1/Auth/helpers/router_helper.dart';
import 'package:gsg_firebase1/Auth/models/friestore_register.dart';
import 'package:gsg_firebase1/Auth/models/user_model.dart';
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
  TextEditingController fNameController = TextEditingController();
  TextEditingController lNameController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  AuthHelper authHelper = AuthHelper.authHelper;
  String response = 'gg';
  LoginState loginState = LoginState.signUp;
  List<UserModel> users = [];
  authenticate() async {
    loginState == LoginState.signUp ? await signUp() : await signIn();
  }

  Future<void> signUp() async {
    if (passwordController.text != confirmPasswordController.text) {
      CustomDialog.customDialog.showCustomDialog('No Match Password');
    } else {
      try {
        UserCredential userCredential = await authHelper.signUp(
            emailController.text, passwordController.text);
        await sendVerificationEmailAndSignOut();
        resetControllers();
        switchLoginState();
      } catch (e) {
        CustomDialog.customDialog.showCustomDialog('Error when sign up: $e');
      }
    }
  }

  Future<void> signIn() async {
    UserCredential userCredential =
        await authHelper.signIn(emailController.text, passwordController.text);
    FirestoreRegister firestoreRegister = FirestoreRegister(
        id: userCredential.user.uid,
        email: emailController.text,
        fName: fNameController.text,
        lName: lNameController.text,
        city: cityController.text,
        country: countryController.text);
    await FirestoreHelper.fireStoreHelper.addUserToFirestore(firestoreRegister);
    await FirestoreHelper.fireStoreHelper
        .getUserFromFirestore(userCredential.user.uid);
    if (authHelper.checkEmailVerified()) {
      await getAllUsers();
      RouterHelper.router
          .goReplacementPage(Statics.statics.homePageScreenRoute);
      resetControllers();
      loginState = LoginState.signUp;
    } else
      CustomDialog.customDialog.showCustomDialog(
          'your email is not verified, press ok to send another verification email',
          sendVerificationEmailAndSignOut);
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
    fNameController.clear();
    lNameController.clear();
    countryController.clear();
    cityController.clear();
  }

  resetPassword() async {
    await authHelper.resetPassword(emailController.text);
  }

  sendVerificationEmailAndSignOut() async {
    await authHelper.sendVerificationEmail();
    await authHelper.signOut();
  }

  getAllUsers() async {
    users = await FirestoreHelper.fireStoreHelper.getAllUsers();
    notifyListeners();
  }
}
