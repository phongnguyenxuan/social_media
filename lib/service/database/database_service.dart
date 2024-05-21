import 'package:blog/core/constants/firebase_constants.dart';
import 'package:blog/service/logger/logger.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../models/user_model.dart';

class DatabaseServices {
  final _databases = FirebaseFirestore.instance;

  Future<void> saveUserData(UserModel userModel) async {
    try {
      await _databases
          .collection(FirebaseConstants.userCollectionId)
          .doc(userModel.id)
          .set(userModel.toJson());
      logSuccess(
          "success create user document : ${userModel.toJson().toString()}");
    } on FirebaseException catch (e) {
      logError(e);
    }
  }

  Future<UserModel?> getUserData(String id) async {
    try {
      final result = await _databases
          .collection(FirebaseConstants.userCollectionId)
          .doc(id)
          .get();
      UserModel userModel = UserModel.fromJson(result.data()!);
      logSuccess("User data ${userModel.toJson().toString()}");
      return userModel;
    } on FirebaseException catch (e) {
      logError(e);
      return null;
    }
  }
}
