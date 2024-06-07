import 'package:blog/core/constants/regex.dart';
import 'package:blog/modules/auth/login/login_state.dart';
import 'package:blog/routes/app_routes.dart';
import 'package:blog/service/logger/logger.dart';
import 'package:blog/service/network/apis/api_client.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class LoginLogic extends GetxController {
  final LoginState state = LoginState();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final ApiClient apiClient = ApiClient();

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  void onChangeHidePass() {
    state.hidePassword.value = !state.hidePassword.value;
  }

  void login() async {
    if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {
      try {
        if (state.emailValidator.value == "" &&
            state.passwordValidator.value == "") {
          EasyLoading.show();
          await apiClient.login(
              email: emailController.text, password: passwordController.text);
          EasyLoading.dismiss();
          pushToMainView();
        }
        // Get.toNamed(AppRoutes.MAIN);
      } on DioException catch (e) {
        EasyLoading.dismiss();
        var response = e.response?.data;
        String message = response['data'];
        switch (message) {
          case "Incorrect password":
            state.passwordValidator.value = "Incorrect password";
            break;
          case "This email was not found on the system":
            state.emailValidator.value =
                "This email was not found on the system";
            break;
        }
        logError(e.response?.data["data"]);
      }
    }
  }

  void pushToRegisterView() {
    Get.toNamed(AppRoutes.REGISTER);
  }

  void pushToForgotPassView() {
    Get.toNamed(AppRoutes.FORGOT_PASSWORD);
  }

  void pushToMainView() {
    Get.toNamed(AppRoutes.MAIN);
  }

  String? mailValidator(String value) {
    if (value.isEmpty) {
      state.emailValidator.value = 'Email is required';
      return 'Email is required';
    }
    final validCharacters = RegExp(mailRegex);
    if (!validCharacters.hasMatch(value)) {
      state.emailValidator.value = 'Invalid email';
      return 'Invalid email';
    }
    state.emailValidator.value = "";
    return "";
  }
}
