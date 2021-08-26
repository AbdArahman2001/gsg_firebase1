import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gsg_firebase1/Auth/models/country_model.dart';
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

  Future<UserModel> getUserFromFirestore(String id) async {
    DocumentSnapshot info =
        await firebaseFirestore.collection('Users').doc(id).get();
    UserModel userModel = UserModel.fromMap(info.data());
    return userModel;
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

  Future<List<CountryModel>> getCountriesCollection() async {
    try {
      QuerySnapshot<Map<String, dynamic>> countriesCollection =
          await firebaseFirestore.collection('Countries').get();
      List<QueryDocumentSnapshot<Map<String, dynamic>>> docs =
          countriesCollection.docs;
      List<CountryModel> countries = docs.map((map) {
        String id = map.id;
        Map myMap = map.data()..addEntries([MapEntry('id', id)]);
        return CountryModel.fromMap(myMap);
      }).toList();
      return countries;
    } catch (e) {
      print(e);
    }
  }
}
