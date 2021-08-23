import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gsg_firebase1/Auth/models/friestore_register.dart';
import 'package:gsg_firebase1/Auth/models/user_model.dart';

class FirestoreHelper {
  FirestoreHelper._();
  static final fireStoreHelper = FirestoreHelper._();
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  addUserToFirestore(FirestoreRegister firestoreRegister) async {
    await firebaseFirestore
        .collection('Users')
        .doc(firestoreRegister.id)
        .set(HashMap.from(firestoreRegister.toMap()));
  }

  getUserFromFirestore(String id) async {
    DocumentSnapshot info =
        await firebaseFirestore.collection('Users').doc(id).get();
    print('user data: ${info.data()}');
  }

  Future<List<UserModel>> getAllUsers() async {
    QuerySnapshot<Map> querySnapshot =
        await firebaseFirestore.collection('Users').get();
    List<QueryDocumentSnapshot<Map>> docs = querySnapshot.docs;
    List<UserModel> users =
        docs.map((userMap) => UserModel.fromMap(userMap.data())).toList();
    return users;
  }
}
