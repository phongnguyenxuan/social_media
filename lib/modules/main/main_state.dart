// ignore_for_file: empty_constructor_bodies

import 'package:blog/core/constants/env.dart';
import 'package:blog/models/user_model.dart';
import 'package:blog/modules/home/home_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainState {
  Rx<UserModel?> userLogin = UserModel().obs;
  RxInt currentTab = AppKey.TAB_HOME.obs;
  List<Widget> pageList = [];
  late PageController pageViewController;

  MainState() {
    pageList = [
      const HomeView(),
      Container(
        color: Colors.red,
      ),
      Container(
        color: Colors.blue,
      ),
      Container(
        color: Colors.pink,
      ),
    ];
  }
}
