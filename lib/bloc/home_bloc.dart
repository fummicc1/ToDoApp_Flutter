import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:today_do/bloc/base.dart';
import 'package:today_do/model/base.dart';
import 'package:today_do/model/user.dart';

class HomeBLoC with BaseBLoC<UserModel, UserModel> {
  HomeBLoC() {
    Stream<UserModel> userStream =
        repository.listenUserState().asyncMap((firebaseUser) async {
      if (firebaseUser == null) {
        return await _signin().then((user) => UserModel(user));
      }
      return UserModel(firebaseUser);
    });

    controller.addStream(userStream);

    actionController.stream.listen((userModel) {
      userModel.loginDate = DateTime.now();
      _persistUser(userModel);
    });
  }

  Future<FirebaseUser> _signin() => repository.signinAnonymously().then((result) => result.user);

  void _persistUser(UserModel user) {
    repository.create(user);
  }
}
