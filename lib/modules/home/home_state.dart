import 'package:blog/models/post_model.dart';
import 'package:blog/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomeState {
  Rx<UserModel?> userLogin = UserModel().obs;
  Rx<RefreshController> refreshController =
      RefreshController(initialRefresh: false).obs;

  Rx<ScrollController> homeScrollCtrl = ScrollController().obs;
  RxList<PostModel> listNewFeeds = <PostModel>[].obs;
  RxBool canLoadMore = true.obs;
  RxInt page = 1.obs;
  HomeState() {}
}
