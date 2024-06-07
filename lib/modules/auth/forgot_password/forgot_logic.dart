import 'package:blog/core/constants/regex.dart';
import 'package:blog/modules/auth/forgot_password/forgot_state.dart';
import 'package:blog/service/logger/logger.dart';
import 'package:blog/service/network/apis/api_client.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class ForgotPasswordLogic extends GetxController {
  final ForgotPasswordState state = ForgotPasswordState();
  final TextEditingController emailController = TextEditingController();
  final PageController pageController = PageController(initialPage: 0);

  final ApiClient apiClient = ApiClient();

  void nextPage() {
    switch (pageController.page) {
      case 0.0:
        mailValidator(emailController.text);
        break;
      case 1.0:
        // mailValidator(emailController.text);
        // if (state.mailValidator.value == "") {
        //   pageController.nextPage(
        //     duration: const Duration(milliseconds: 500),
        //     curve: Curves.ease,
        //   );
        // }
        break;
    }
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
    } else {
      sendOTP(email: value);
    }
    return "";
  }

  Future<void> sendOTP({required String email}) async {
    try {
      EasyLoading.show();
      await apiClient.sendOTP(email: email);
      EasyLoading.dismiss();
      state.emailValidator.value = "";
      pageController.nextPage(
        duration: const Duration(milliseconds: 500),
        curve: Curves.ease,
      );
    } on DioException catch (e) {
      EasyLoading.dismiss();
      logError(e.response?.data['data']);
      var data = e.response?.data['data'];
      state.emailValidator.value = data;
    }
  }
}
