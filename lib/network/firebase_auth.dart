import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthProvider {

  Stream<FirebaseUser> listenUserState() => FirebaseAuth.instance.onAuthStateChanged;

  Future<void> deleteUser(FirebaseUser user) => user.delete();

  Future<AuthResult> signinAnonymously() => FirebaseAuth.instance.signInAnonymously();

}