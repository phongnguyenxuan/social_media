// ignore_for_file: empty_constructor_bodies

import 'package:get/get.dart';

class LoginState {
  RxBool hidePassword = true.obs;
  RxString passwordValidator = "".obs;
  RxString emailValidator = "".obs;

  LoginState() {}
}
