import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gsg_firebase1/Auth/helpers/auth_helper.dart';
import 'package:gsg_firebase1/Auth/helpers/fire_store_helper.dart';
import 'package:gsg_firebase1/Auth/helpers/firebase_storage_helper.dart';
import 'package:gsg_firebase1/Auth/helpers/router_helper.dart';
import 'package:gsg_firebase1/Auth/models/country_model.dart';
import 'package:gsg_firebase1/Auth/models/friestore_register.dart';
import 'package:gsg_firebase1/Auth/models/user_model.dart';
import 'package:gsg_firebase1/Auth/ui/widgets/custom_dialog.dart';
import 'package:gsg_firebase1/statics/statics.dart';
import 'dart:io';

import 'package:image_picker/image_picker.dart';

enum LoginState {
  signUp,
  signIn,
}

class AuthProvider extends ChangeNotifier {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController fNameController = TextEditingController();
  TextEditingController lNameController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  AuthHelper authHelper = AuthHelper.authHelper;
  String response = 'gg';
  LoginState loginState = LoginState.signUp;
  List<UserModel> users = [];
  List<CountryModel> countries = [];
  CountryModel selectedCountry;
  List selectedCities = [];
  String selectedCity;
  File pickedImage;
  String imageUrl;
  UserModel currentUser;

  AuthProvider() {
    getAllCountries();
  }

  authenticate() async {
    loginState == LoginState.signUp ? await signUp() : await signIn();
  }

  Future<void> signUp() async {
    if (passwordController.text != confirmPasswordController.text) {
      CustomDialog.customDialog.showCustomDialog('No Match Password');
    } else {
      try {
        UserCredential userCredential = await authHelper.signUp(
            emailController.text.replaceAll(' ', ''), passwordController.text);
        await uploadFile();
        FirestoreRegister firestoreRegister = FirestoreRegister(
            id: userCredential.user.uid,
            email: emailController.text.replaceAll(' ', ''),
            fName: fNameController.text,
            lName: lNameController.text,
            city: selectedCity,
            country: selectedCountry.name,
            imageUrl: imageUrl);
        await FirestoreHelper.fireStoreHelper
            .addUserToFirestore(firestoreRegister);
        await sendVerificationEmailAndSignOut();
        switchLoginState();
        resetControllers();
      } catch (e) {
        CustomDialog.customDialog.showCustomDialog('Error when sign up: $e');
      }
    }
  }

  Future<void> signIn() async {
    UserCredential userCredential = await authHelper.signIn(
        emailController.text.replaceAll(' ', ''), passwordController.text);
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
  }

  resetPassword() async {
    await authHelper.resetPassword(emailController.text.replaceAll(' ', ''));
  }

  sendVerificationEmailAndSignOut() async {
    await authHelper.sendVerificationEmail();
    await authHelper.signOut();
  }

  getAllUsers() async {
    users = await FirestoreHelper.fireStoreHelper.getAllUsers();
    notifyListeners();
  }

  getAllCountries() async {
    countries = await FirestoreHelper.fireStoreHelper.getCountriesCollection();
    selectCountry(countries.first);
    selectCity(selectedCities.first);
    notifyListeners();
  }

  selectCountry(CountryModel countryModel) {
    this.selectedCountry = countryModel;
    selectedCities = countryModel.cities;
    selectCity(selectedCities.first);
    notifyListeners();
  }

  selectCity(String city) {
    this.selectedCity = city.toString();
    notifyListeners();
  }

  pickImage() async {
    try {
      XFile image = await ImagePicker().pickImage(source: ImageSource.gallery);
      pickedImage = File(image.path);
    } catch (e) {
      print(e);
    }
    notifyListeners();
  }

  uploadFile() async {
    imageUrl = await FirebaseStorageHelper.firebaseStorageHelper
        .uploadFile(pickedImage);
  }

  getCurrentUser() async {
    currentUser = await FirestoreHelper.fireStoreHelper
        .getUserFromFirestore(FirebaseAuth.instance.currentUser.uid);

    notifyListeners();
  }
}
