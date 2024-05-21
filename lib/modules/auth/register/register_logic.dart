import 'package:blog/core/constants/regex.dart';
import 'package:blog/core/utils/string_helper.dart';
import 'package:blog/models/user_model.dart';
import 'package:blog/modules/auth/register/register_state.dart';
import 'package:blog/service/auth/auth_service.dart';
import 'package:blog/service/database/database_service.dart';
import 'package:blog/service/logger/logger.dart';
import 'package:firebase_core/firebase_core.dart';
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
  final AuthService authService = AuthService();
  final DatabaseServices databaseServices = DatabaseServices();
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
      var user = await authService.signUp(
          email: emailController.text, password: passwordController.text);
      UserModel userModel = UserModel(
        id: user.user?.uid,
        name: StringUtils.validateString(nameController.text),
        email: user.user?.email,
        follower: [],
        following: [],
        emailVerification: user.user?.emailVerified,
        status: true,
        createdAt: DateTime.now().toString(),
      );
      await databaseServices.saveUserData(userModel);
      EasyLoading.dismiss();
    } on FirebaseException catch (e) {
      logError(e);
      EasyLoading.dismiss();
      if (e.code == "email-already-in-use") {
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
