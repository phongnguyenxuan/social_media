import 'dart:async';

import 'package:appwrite/appwrite.dart';
import 'package:blog/service/appwrite/appwrite_service.dart';
import 'package:appwrite/models.dart' as model;

class AuthService {
  final Account _account = Account(AppwriteService.instance.client);

  Future<model.User> signUp(
      {String? name, required String email, required String password}) async {
    final account = await _account.create(
        userId: ID.unique(), email: email, password: password);
    return account;
  }

  Future<model.User> logIn(
      {required String email, required String password}) async {
    await _account.createEmailPasswordSession(email: email, password: password);
    return _account.get();
  }

  Future<model.User?> currentUser() async {
    try {
      return await _account.get();
    } on AppwriteException {
      return null;
    } catch (e) {
      return null;
    }
  }
}
