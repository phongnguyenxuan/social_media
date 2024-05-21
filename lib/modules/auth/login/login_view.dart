import 'package:blog/common/widget/custom_button.dart';
import 'package:blog/common/widget/logo.dart';
import 'package:blog/core/constants/assets_constants.dart';
import 'package:blog/core/themes/color.dart';
import 'package:blog/modules/auth/login/login_logic.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../common/widget/custom_text_field.dart';
import '../../../core/themes/textstyle.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final logic = Get.find<LoginLogic>();
  final state = Get.find<LoginLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Container(
          constraints:
              BoxConstraints(minHeight: MediaQuery.of(context).size.height),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Center(
                child: Logo(
                  size: 50,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                child: CustomTextField(
                  tiltle: "Email",
                  controller: logic.emailController,
                  isPassword: false,
                ),
              ),
              Obx(
                () {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
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
              const SizedBox(
                height: 20,
              ),
              //forgot password
              Padding(
                padding: const EdgeInsets.only(right: 15),
                child: InkWell(
                  onTap: () {},
                  child: Text(
                    "Forgot the password?",
                    style: AppTextStyle.linkStyle
                        .copyWith(fontSize: 15, fontWeight: FontWeight.w700),
                  ),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: CustomButton.full(
                    onTap: () {
                      logic.login();
                    },
                    child: Center(
                        child: Text(
                      "Login",
                      style: AppTextStyle.robotoregular.copyWith(
                          fontSize: 15,
                          color: AppColors.lightBackground,
                          fontWeight: FontWeight.w700),
                    )),
                  ),
                ),
              ),
              Center(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                  child: CustomButton.outLine(
                    onTap: () {},
                    padding: const EdgeInsets.all(0),
                    child: Center(
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                                width: 25,
                                child: SvgPicture.asset(AppAssets.google_icon)),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Login with Google",
                              style: AppTextStyle.linkStyle.copyWith(
                                  fontSize: 15, fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Center(
                child: RichText(
                    text: TextSpan(
                        text: "Don't have account? ",
                        style: AppTextStyle.robotoregular.copyWith(
                            color: AppColors.greyColor1, fontSize: 15),
                        children: [
                      TextSpan(
                        text: "Sign up",
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            logic.pushToRegisterView();
                          },
                        style: AppTextStyle.linkStyle.copyWith(
                            fontSize: 15, fontWeight: FontWeight.w700),
                      )
                    ])),
              )
            ],
          ),
        ),
      ),
    );
  }
}
