import 'package:firebase_auth/firebase_auth.dart';
import 'package:gsg_firebase1/Auth/helpers/router_helper.dart';
import 'package:gsg_firebase1/Auth/ui/widgets/custom_dialog.dart';
import 'package:gsg_firebase1/statics/statics.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthHelper {
  AuthHelper._();

  static final authHelper = AuthHelper._();
  FirebaseAuth auth = FirebaseAuth.instance;

  Future<UserCredential> signUp(String email, String password) async {
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return userCredential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        CustomDialog.customDialog
            .showCustomDialog('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        CustomDialog.customDialog
            .showCustomDialog('The account already exists for that email.');
      } else if (e.code == 'invalid-email') {
        CustomDialog.customDialog.showCustomDialog('Invalid email');
      } else {
        CustomDialog.customDialog.showCustomDialog(e.code);
      }
    } catch (e) {
      CustomDialog.customDialog.showCustomDialog(e.toString());
    }
  }

  Future<UserCredential> signIn(String email, String password) async {
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      print('uid: ${userCredential.user.uid}');
      print('get id token: ${await userCredential.user.getIdToken()}');
      return userCredential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        CustomDialog.customDialog
            .showCustomDialog('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        CustomDialog.customDialog
            .showCustomDialog('Wrong password provided for that user.');
      } else if (e.code == 'invalid-email') {
        CustomDialog.customDialog.showCustomDialog('Invalid email');
      } else {
        CustomDialog.customDialog.showCustomDialog(e.code);
      }
    } catch (e) {
      CustomDialog.customDialog.showCustomDialog(e.toString());
    }
  }

  sendVerificationEmail() async {
    User user = auth.currentUser;
    if (user != null) {
      await user.sendEmailVerification();
      CustomDialog.customDialog.showCustomDialog(
          'verification email has been sent, please check your email');
    }
  }

  bool checkEmailVerified() {
    bool isVerified = auth.currentUser?.emailVerified ?? false;
    print('current user: ${auth.currentUser.toString()}');
    return isVerified;
  }

  signOut() async {
    await auth.signOut();
  }

  resetPassword(String email) async {
    try {
      await auth.sendPasswordResetEmail(email: email);
      CustomDialog.customDialog.showCustomDialog(
          'we have sent email for reset password, please check your email');
    } on Exception catch (e) {
      CustomDialog.customDialog.showCustomDialog('error when reset password');
    }
  }

  Future<User> getCurrentUser() async {
    return auth.currentUser;
  }
}
