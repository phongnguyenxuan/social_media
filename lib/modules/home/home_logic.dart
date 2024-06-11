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

  Future<void> loadData() async {
    Future.wait([
      getUserInfo(),
      getNewFeeds(),
    ]);
  }

  Future<void> getNewFeeds({int page = 1, int limit = 10}) async {
    try {
      final result =
          await apiClient.getNewFeeds(page: page, limit: limit) ?? [];
      if (result.isNotEmpty) {
        state.canLoadMore.value = true;
      } else {
        state.canLoadMore.value = false;
      }
      if (page == 1) {
        state.listNewFeeds.value = result;
      } else {
        state.listNewFeeds.addAll(result);
      }
      state.listNewFeeds.refresh();
    } catch (e) {
      logError(e);
      state.canLoadMore.value = false;
    }
  }

  Future<void> loadMore() async {
    try {
      if (state.canLoadMore.value) {
        state.page.value += 1;
        await getNewFeeds(
          page: state.page.value,
          limit: 10,
        );
      }
    } catch (e) {
      logError(e);
    } finally {
      state.refreshController.value.loadComplete();
    }
  }

  Future<void> pullToRefresh() async {
    await loadData().then((value) {
      state.refreshController.value.refreshCompleted();
      state.refreshController.value.loadComplete();
    });
  }

  Future<void> getUserInfo() async {
    String userId = sharedPreferencesManager.getString(PreferenceKey.user_id);
    state.userLogin.value = await apiClient.getUserInfo(id: userId);
    logSuccess(state.userLogin.value?.name);
  }
}
