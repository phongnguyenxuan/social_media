import 'package:blog/models/user_model.dart';
import 'package:get/get.dart';

class MainState {
  Rx<UserModel> user = UserModel().obs;

  MainState() {}
}
