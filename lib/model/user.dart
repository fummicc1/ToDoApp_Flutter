
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:today_do/model/base.dart';

class UserModel with BaseModel {

  String uid;

  UserModel(FirebaseUser firebaseUser) {
    this.uid = firebaseUser.uid;
  }

  UserModel.fromJSON(Map<String, dynamic> json) {
    uid = json["uid"];
  }

  @override
  Map<String, dynamic> get json => {
    "uid": uid,
  };

  @override
  DocumentReference get ref => Firestore.instance.collection("users").document(uid);


}