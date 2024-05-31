import 'package:blog/core/constants/preference_key.dart';
import 'package:blog/models/user_model.dart';
import 'package:blog/modules/main/main_state.dart';
import 'package:blog/service/database/local_database_service.dart';
import 'package:get/get.dart';

class MainLogic extends GetxController {
  final MainState state = MainState();
  final SharedPreferencesManager sharedPreferencesManager =
      SharedPreferencesManager.instance;
  @override
  void onInit() {
    loadData();
    super.onInit();
  }

  void loadData() async {
    getUserInfo();
  }

  void getUserInfo() async {
    String userId = sharedPreferencesManager.getString(PreferenceKey.user_id);
    // await databaseServices
    //     .getUserData(FirebaseAuth.instance.currentUser!.uid)
    //     .then((value) => state.user.value = value ?? UserModel());
  }
}
