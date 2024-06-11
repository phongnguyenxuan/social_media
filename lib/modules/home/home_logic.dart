import 'package:blog/core/constants/preference_key.dart';
import 'package:blog/modules/home/home_state.dart';
import 'package:blog/service/database/local_database_service.dart';
import 'package:blog/service/logger/logger.dart';
import 'package:blog/service/network/apis/api_client.dart';
import 'package:get/get.dart';

class HomeLogic extends GetxController {
  final HomeState state = HomeState();
  final ApiClient apiClient = ApiClient();
  final SharedPreferencesManager sharedPreferencesManager =
      SharedPreferencesManager.instance;
  @override
  void onInit() {
    super.onInit();
    loadData();
  }

  void loadData() async {
    //getUserInfo();
    getNewFeeds();
  }

  void getNewFeeds() async {
    state.listNewFeeds.value =
        await apiClient.getNewFeeds(page: 1, limit: 10) ?? [];
  }

  void getUserInfo() async {
    String userId = sharedPreferencesManager.getString(PreferenceKey.user_id);
    state.userLogin.value = await apiClient.getUserInfo(id: userId);
    logSuccess(state.userLogin.value?.name);
  }
}
