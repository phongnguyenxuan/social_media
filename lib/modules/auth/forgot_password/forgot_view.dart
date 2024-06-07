import 'package:blog/common/widget/app_bar/custom_appbar.dart';
import 'package:blog/common/widget/custom_button.dart';
import 'package:blog/common/widget/on_board_slider.dart/flutter_onboarding_slider.dart';
import 'package:blog/common/widget/otp_text_field/otp_widget.dart';
import 'package:blog/core/themes/color.dart';
import 'package:blog/core/themes/textstyle.dart';
import 'package:blog/modules/auth/forgot_password/forgot_logic.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common/widget/custom_text_field.dart';

class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({super.key});

  @override
  State<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  final logic = Get.find<ForgotPasswordLogic>();
  final state = Get.find<ForgotPasswordLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: AppColors.lightBackground,
      appBar: const CustomAppBar(
        type: AppbarType.normal,
      ),
      body: OnBoardingSlider(
        totalPage: 3,
        addButton: false,
        hasFloatingButton: true,
        headerBackgroundColor: AppColors.lightBackground,
        pageBackgroundColor: AppColors.lightBackground,
        finishButtonTextStyle: AppTextStyle.robotoregular.copyWith(
            fontSize: 15, color: Colors.white, fontWeight: FontWeight.w700),
        speed: 1,
        pageController: logic.pageController,
        pageBodies: [
          emailForm(),
          otpForm(),
          otpForm(),
        ],
      ),
    );
  }

  Widget emailForm() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Forgot password",
              style: AppTextStyle.headerStyle.copyWith(fontSize: 20),
            ),
            const SizedBox(
              height: 18,
            ),
            Text(
              "Please enter your email to reset the password",
              style: AppTextStyle.header2Style
                  .copyWith(fontSize: 16, color: AppColors.greyColor2),
            ),
            const SizedBox(
              height: 58,
            ),
            Obx(
              () => CustomTextField(
                tiltle: "Email",
                controller: logic.emailController,
                isPassword: false,
                validator: state.emailValidator.value,
                // onHide: () => logic.onChangeHidePass(),
                // onChanged: (value) {
                //   state.passwordValidator.value = "";
                // },
              ),
            ),
            const SizedBox(
              height: 26,
            ),
            CustomButton.full(
              onTap: () {
                logic.nextPage();
                setState(() {});
              },
              child: Center(
                  child: Text(
                "Next",
                style: AppTextStyle.robotoregular.copyWith(
                    fontSize: 15,
                    color: AppColors.lightBackground,
                    fontWeight: FontWeight.w700),
              )),
            ),
          ],
        ),
      ),
    );
  }

  Widget otpForm() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Check your email",
              style: AppTextStyle.headerStyle.copyWith(fontSize: 20),
            ),
            const SizedBox(
              height: 18,
            ),
            RichText(
                text: TextSpan(
                    text: 'We sent a verify code to contact ',
                    children: [
                      TextSpan(
                          text: logic.emailController.text,
                          style: AppTextStyle.header2Style
                              .copyWith(color: AppColors.greyColor3)),
                      const TextSpan(
                          text:
                              '\nenter 5 digit code that mentioned in the email')
                    ],
                    style: AppTextStyle.header2Style
                        .copyWith(color: AppColors.greyColor2, fontSize: 16))),
            const SizedBox(
              height: 58,
            ),
            OtpTextField(
              numberOfFields: 6,
              keyboardType: TextInputType.number,
              showFieldAsBox: true,
            ),
            const SizedBox(
              height: 26,
            ),
            CustomButton.full(
              onTap: logic.nextPage,
              child: Center(
                  child: Text(
                "Verify",
                style: AppTextStyle.robotoregular.copyWith(
                    fontSize: 15,
                    color: AppColors.lightBackground,
                    fontWeight: FontWeight.w700),
              )),
            ),
          ],
        ),
      ),
    );
  }
}
