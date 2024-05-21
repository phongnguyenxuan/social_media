import 'package:blog/models/user_model.dart';
import 'package:blog/modules/main/main_state.dart';
import 'package:blog/service/auth/auth_service.dart';
import 'package:blog/service/database/database_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class MainLogic extends GetxController {
  final MainState state = MainState();
  final DatabaseServices databaseServices = DatabaseServices();
  final AuthService authService = AuthService();

  @override
  void onInit() {
    loadData();
    super.onInit();
  }

  void loadData() async {
    getUserInfo();
  }

  void getUserInfo() async {
    await databaseServices
        .getUserData(FirebaseAuth.instance.currentUser!.uid)
        .then((value) => state.user.value = value ?? UserModel());
  }
}
