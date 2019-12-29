
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:today_do/model/base.dart';

class UserModel with BaseModel {

  static const String collectionName = "users";

  String uid;
  DateTime loginDate;
  List<DocumentReference> todoRefList;

  UserModel.empty() {
    uid = "";
  }

  UserModel(FirebaseUser firebaseUser) {
    this.uid = firebaseUser.uid;
  }

  UserModel.fromJSON(Map<String, dynamic> json) {

    uid = json["uid"];
    var _loginDate = json["login_date"];
    if (_loginDate is Timestamp) {
      loginDate = _loginDate.toDate();
    }
    todoRefList = json["todo_ref_list"];
  }

  @override
  Map<String, dynamic> get json => {
    "uid": uid,
    "login_date": loginDate,
    "todo_ref_list": todoRefList,
  };

  @override
  DocumentReference get ref => Firestore.instance.collection(UserModel.collectionName).document(uid);
}