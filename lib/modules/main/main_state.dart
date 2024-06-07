// ignore_for_file: empty_constructor_bodies

import 'package:blog/models/user_model.dart';
import 'package:get/get.dart';

class MainState {
  Rx<UserModel?> userLogin = UserModel().obs;

  MainState() {}
}
