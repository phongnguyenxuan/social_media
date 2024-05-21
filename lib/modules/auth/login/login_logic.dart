import 'package:blog/modules/auth/login/login_state.dart';
import 'package:blog/routes/app_routes.dart';
import 'package:blog/service/auth/auth_service.dart';
import 'package:blog/service/logger/logger.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginLogic extends GetxController {
  final LoginState state = LoginState();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final AuthService authService = AuthService();

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
        await authService.logIn(
            email: emailController.text, password: passwordController.text);
      } catch (e) {
        logError(e);
      }
    }
  }

  void pushToRegisterView() {
    Get.toNamed(AppRoutes.REGISTER);
  }

  void pushToMainView() {
    Get.toNamed(AppRoutes.MAIN);
  }
}
