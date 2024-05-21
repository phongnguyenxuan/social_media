import 'package:appwrite/appwrite.dart';
import 'package:blog/core/constants/appwrite_constants.dart';

class AppwriteService {
  static final AppwriteService instance = AppwriteService.internal();
  late final Client client;
  factory AppwriteService() => instance;

  AppwriteService.internal() {
    client = Client()
        .setEndpoint(AppWriteConstants.baseURL)
        .setProject(AppWriteConstants.projectId);
  }
}
