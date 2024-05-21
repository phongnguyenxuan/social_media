import 'package:blog/core/constants/regex.dart';
import 'package:blog/modules/auth/register/register_state.dart';
import 'package:blog/service/auth/auth_service.dart';
import 'package:blog/service/logger/logger.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterLogic extends GetxController {
  final RegisterState state = RegisterState();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final PageController pageController = PageController(initialPage: 0);
  final AuthService authService = AuthService();
  final nameKey = GlobalKey<FormState>();
  final mailKey = GlobalKey<FormState>();
  final passKey = GlobalKey<FormState>();

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

  void login() async {
    if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {
      try {
        await authService
            .logIn(
                email: emailController.text, password: passwordController.text)
            .then((value) {});
      } catch (e) {
        logError(e);
      }
    }
  }

  void goToNextPage(BuildContext context) {
    logSuccess("name ${nameController.text}");
    logSuccess("mail ${emailController.text}");
    logSuccess("Going here ${nameValidator(nameController.text)}");
    switch (pageController.page) {
      case 0.0:
        if (nameValidator(nameController.text) == "") {
          pageController.nextPage(
            duration: const Duration(milliseconds: 500),
            curve: Curves.ease,
          );
        }
        break;
      case 1.0:
        if (mailKey.currentState!.validate()) {
          pageController.nextPage(
            duration: const Duration(milliseconds: 500),
            curve: Curves.ease,
          );
        }
        break;
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
    return "";
  }

  String? mailValidator(String value) {
    if (value.isEmpty) {
      return 'Email is required';
    }
    final validCharacters = RegExp(mailRegex);
    if (!validCharacters.hasMatch(value)) {
      return 'Invalid email';
    }
    return null;
  }

  String? passValidator(String value) {
    if (value.isEmpty) {
      return 'Password is required';
    }
    final validCharacters = RegExp(passRegex);
    if (!validCharacters.hasMatch(value)) {
      return 'Password must be at least 8 characters long, include an uppercase letter, a lowercase letter, a digit, and a special character';
    }
    return null;
  }

  String? confirmPassValidator(String value) {
    if (value.isEmpty) {
      return 'Confirm password is required';
    }
    if (value != passwordController.text) {
      return 'Password do not match';
    }
    return null;
  }
}
