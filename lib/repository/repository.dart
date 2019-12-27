import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:today_do/model/base.dart';
import 'package:today_do/network/firebase_auth.dart';
import 'package:today_do/network/firestore.dart';

class Repository {

  FirestoreProvider _dataProvider = FirestoreProvider();
  FirebaseAuthProvider _authProvider = FirebaseAuthProvider();

  Future<void> create(BaseModel model) => _dataProvider.create(model.ref, model.json);

  Stream<QuerySnapshot> listen(CollectionReference ref) => _dataProvider.listen(ref);

  Stream<FirebaseUser> listenUserState() => _authProvider.listenUserState();

  Future<AuthResult> signinAnonymously() => _authProvider.signinAnonymously();
}