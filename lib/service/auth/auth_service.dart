import 'dart:async';
import 'package:blog/service/logger/logger.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final auth = FirebaseAuth.instance;

  Future<UserCredential> signUp(
      {required String email, required String password}) async {
    final account = await auth.createUserWithEmailAndPassword(
        email: email, password: password);
    return account;
  }

  Future<UserCredential?> logIn(
      {required String email, required String password}) async {
    try {
      final account = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      logSuccess("Login Success");
      return account;
    } on FirebaseAuthException catch (e) {
      logError(e);
      return null;
    }
  }

  Future<void> logOut() async {
    try {
      await auth.signOut();
      logSuccess("Success signout");
    } on FirebaseAuthException catch (e) {
      logError(e);
    }
  }
}
