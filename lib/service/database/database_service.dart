import 'package:appwrite/appwrite.dart';
import 'package:blog/core/constants/appwrite_constants.dart';
import 'package:blog/service/appwrite/appwrite_service.dart';
import 'package:blog/service/logger/logger.dart';
import '../../models/user_model.dart';

class DatabaseServices {
  final Databases _databases = Databases(AppwriteService.instance.client);

  Future<void> saveUserData(UserModel userModel) async {
    try {
      _databases.createDocument(
        databaseId: AppWriteConstants.databaseId,
        collectionId: AppWriteConstants.userCollectionId,
        documentId: userModel.id!,
        data: userModel.toJson(),
      );
      logSuccess(
          "success create user document : ${userModel.toJson().toString()}");
    } on AppwriteException catch (e) {
      logError(e);
    }
  }
}
