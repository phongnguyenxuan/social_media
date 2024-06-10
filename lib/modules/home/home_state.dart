import 'package:blog/models/user_model.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomeState {
  Rx<UserModel?> userLogin = UserModel().obs;
  Rx<RefreshController> refreshController =
      RefreshController(initialRefresh: false).obs;
  HomeState() {}
}
