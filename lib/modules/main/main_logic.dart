import 'package:blog/core/constants/env.dart';
import 'package:blog/core/constants/preference_key.dart';
import 'package:blog/modules/main/main_state.dart';
import 'package:blog/service/database/local_database_service.dart';
import 'package:blog/service/logger/logger.dart';
import 'package:blog/service/network/apis/api_client.dart';
import 'package:get/get.dart';

class MainLogic extends GetxController {
  final MainState state = MainState();
  final SharedPreferencesManager sharedPreferencesManager =
      SharedPreferencesManager.instance;
  final ApiClient apiClient = ApiClient();
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
    state.userLogin.value = await apiClient.getUserInfo(id: userId);
    logSuccess(state.userLogin.value?.name);
  }

  void onTabChange({required int selectTabIndex}) {
    if (selectTabIndex != state.currentTab.value) {
      switch (selectTabIndex) {
        case AppKey.TAB_HOME:
          state.pageViewController.jumpToPage(0);
          break;
        case AppKey.TAB_SAVE:
          state.pageViewController.jumpToPage(1);
          break;
        case AppKey.TAB_CONVERSATION:
          state.pageViewController.jumpToPage(2);
          break;
        case AppKey.TAB_ME:
          state.pageViewController.jumpToPage(3);
          break;
      }
      state.currentTab.value = selectTabIndex;
    }
  }
}
