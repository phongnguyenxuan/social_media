import 'package:blog/core/constants/regex.dart';
import 'package:blog/models/user_model.dart';
import 'package:blog/modules/auth/register/register_state.dart';
import 'package:blog/routes/app_routes.dart';
import 'package:blog/service/logger/logger.dart';
import 'package:blog/service/network/apis/api_client.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class RegisterLogic extends GetxController {
  final RegisterState state = RegisterState();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final PageController pageController = PageController(initialPage: 0);
  final nameKey = GlobalKey<FormState>();
  final mailKey = GlobalKey<FormState>();
  final passKey = GlobalKey<FormState>();
  final ApiClient apiClient = ApiClient();

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    super.onClose();
  }

  void onChangeHidePass() {
    state.hidePassword.value = !state.hidePassword.value;
  }

  void goToNextPage(BuildContext context) {
    switch (pageController.page) {
      case 0.0:
        nameValidator(nameController.text);
        if (state.nameValidator.value == "") {
          pageController.nextPage(
            duration: const Duration(milliseconds: 500),
            curve: Curves.ease,
          );
        }
        break;
      case 1.0:
        mailValidator(emailController.text);
        if (state.mailValidator.value == "") {
          pageController.nextPage(
            duration: const Duration(milliseconds: 500),
            curve: Curves.ease,
          );
        }
        break;
    }
  }

  void onFinish() {
    if (state.passValidator.value == "" && state.confirmValidator.value == "") {
      register();
    }
  }

  void register() async {
    try {
      EasyLoading.show();
      UserModel? userModel = await apiClient.register(
          email: emailController.text,
          password: passwordController.text,
          name: nameController.text);
      EasyLoading.dismiss();
      if (userModel != null) {
        Get.offAllNamed(AppRoutes.MAIN);
      }
    } on DioException catch (e) {
      logError(e.response?.data["data"]);
      EasyLoading.dismiss();
      if (e.response?.data['data'] ==
          "This email already exists on the system") {
        pageController.jumpToPage(1);
        state.mailValidator.value = "Email already exists";
      }
    }
  }

  String? nameValidator(String value) {
    if (value.isEmpty) {
      state.nameValidator.value = 'Username is required';
      return 'Username is required';
    }
    if (value.length < 3 || value.length > 15) {
      state.nameValidator.value =
          'Username must be between 3 and 15 characters';
      return 'Username must be between 3 and 15 characters';
    }
    final validCharacters = RegExp(nameRegex);
    if (!validCharacters.hasMatch(value)) {
      state.nameValidator.value =
          'Username can only contain letters, numbers, and underscores';
      return 'Username can only contain letters, numbers, and underscores';
    }
    state.nameValidator.value = "";
    return "";
  }

  String? mailValidator(String value) {
    if (value.isEmpty) {
      state.mailValidator.value = 'Email is required';
      return 'Email is required';
    }
    final validCharacters = RegExp(mailRegex);
    if (!validCharacters.hasMatch(value)) {
      state.mailValidator.value = 'Invalid email';
      return 'Invalid email';
    }
    state.mailValidator.value = "";
    return "";
  }

  String? passValidator(String value) {
    if (value.isEmpty) {
      state.passValidator.value = 'Password is required';
      return 'Password is required';
    }
    final validCharacters = RegExp(passRegex);
    if (!validCharacters.hasMatch(value)) {
      state.passValidator.value =
          'Password must be at least 8 characters long, include an uppercase letter, a lowercase letter, a digit, and a special character';
      return 'Password must be at least 8 characters long, include an uppercase letter, a lowercase letter, a digit, and a special character';
    }
    state.passValidator.value = "";
    return "";
  }

  String? confirmPassValidator(String value) {
    if (value.isEmpty) {
      state.confirmValidator.value = 'Confirm password is required';
      return 'Confirm password is required';
    }
    if (value != passwordController.text) {
      state.confirmValidator.value = 'Password do not match';
      return 'Password do not match';
    }
    state.confirmValidator.value = "";
    return "";
  }
}
