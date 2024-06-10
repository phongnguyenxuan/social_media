import 'package:blog/core/constants/preference_key.dart';
import 'package:blog/routes/app_routes.dart';
import 'package:get/get.dart';

import '../../service/database/local_database_service.dart';
import '../../service/network/apis/api_client.dart';

class SplashLogic extends GetxController {
  final SharedPreferencesManager sharedPreferencesManager =
      SharedPreferencesManager.instance;
  final ApiClient apiClient = ApiClient();

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    Future.delayed(const Duration(seconds: 2)).then(
      (value) => handleNextScreen(),
    );
  }

  void handleNextScreen() {
    String userId = sharedPreferencesManager.getString(PreferenceKey.user_id);
    if (userId != '') {
      Get.offAllNamed(AppRoutes.MAIN);
    } else {
      Get.offAllNamed(AppRoutes.LOGIN);
    }
  }
}
