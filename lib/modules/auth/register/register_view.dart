import 'package:blog/common/widget/logo.dart';
import 'package:blog/common/widget/on_board_slider.dart/flutter_onboarding_slider.dart';
import 'package:blog/core/themes/color.dart';
import 'package:blog/modules/auth/register/register_logic.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common/widget/custom_text_field.dart';
import '../../../core/themes/textstyle.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final logic = Get.find<RegisterLogic>();
  final state = Get.find<RegisterLogic>().state;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: OnBoardingSlider(
        totalPage: 3,
        hasFloatingButton: true,
        headerBackgroundColor: AppColors.lightBackground,
        finishButtonText: "Create account",
        finishButtonTextStyle: AppTextStyle.robotoregular.copyWith(
            fontSize: 15, color: Colors.white, fontWeight: FontWeight.w700),
        speed: 1,
        pageController: logic.pageController,
        onChange: () {
          logic.goToNextPage(context);
        },
        pageBodies: [
          nameForm(context),
          emailForm(context),
          passwordForm(context),
        ],
      ),
    );
  }

  SingleChildScrollView emailForm(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Center(
            child: Logo(
              size: 50,
            ),
          ),
          const SizedBox(
            height: 60,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Text(
              "Create your account",
              style: AppTextStyle.robotoregular
                  .copyWith(fontSize: 25, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            child: CustomTextField(
              formKey: logic.mailKey,
              validator: logic.mailValidator(logic.emailController.text),
              tiltle: "Email",
              controller: logic.emailController,
              isPassword: false,
            ),
          ),
        ],
      ),
    );
  }

  Widget nameForm(BuildContext context) {
    return SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Obx(
          () => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Center(
                child: Logo(
                  size: 50,
                ),
              ),
              const SizedBox(
                height: 60,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Text(
                  "Create your account",
                  style: AppTextStyle.robotoregular
                      .copyWith(fontSize: 25, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                child: CustomTextField(
                  tiltle: "Username",
                  controller: logic.nameController,
                  validator: state.nameValidator.value,
                  isPassword: false,
                ),
              ),
            ],
          ),
        ));
  }

  SingleChildScrollView passwordForm(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          const Center(
            child: Logo(
              size: 50,
            ),
          ),
          const SizedBox(
            height: 60,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Text(
              "Create your account",
              style: AppTextStyle.robotoregular
                  .copyWith(fontSize: 25, fontWeight: FontWeight.bold),
            ),
          ),
          Obx(
            () {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                child: CustomTextField(
                  tiltle: "Password",
                  controller: logic.passwordController,
                  isPassword: true,
                  hidePassword: state.hidePassword.value,
                  onHide: () => logic.onChangeHidePass(),
                ),
              );
            },
          ),
          Obx(
            () {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: CustomTextField(
                  tiltle: "Confirm Password",
                  controller: logic.confirmPasswordController,
                  isPassword: true,
                  hidePassword: state.hideConfirmPassword.value,
                  onHide: () {
                    state.hideConfirmPassword.value =
                        !state.hideConfirmPassword.value;
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
