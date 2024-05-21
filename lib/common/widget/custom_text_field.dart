import 'package:blog/core/themes/color.dart';
import 'package:blog/core/themes/textstyle.dart';
import 'package:blog/service/logger/logger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../core/constants/assets_constants.dart';
import 'gradient_input_boder.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField(
      {super.key,
      required this.tiltle,
      required this.isPassword,
      this.hidePassword,
      this.onHide,
      required this.controller,
      this.hint,
      this.formKey,
      this.validator});
  final String tiltle;
  final TextEditingController controller;
  final bool isPassword;
  final bool? hidePassword;
  final String? hint;
  final void Function()? onHide;
  final GlobalKey<FormState>? formKey;
  final String? validator;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    logSuccess("message ${widget.validator}");
    return TextFormField(
      controller: widget.controller,
      obscureText: widget.hidePassword ?? false,
      decoration: InputDecoration(
        errorText: widget.validator == "" ? null : widget.validator,
        labelText: widget.tiltle,
        labelStyle: AppTextStyle.robotoregular.copyWith(fontSize: 15),
        hintText: widget.hint,
        suffixIcon: widget.isPassword
            ? GestureDetector(
                onTap: widget.onHide,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: SvgPicture.asset(
                    (widget.hidePassword ?? false)
                        ? AppAssets.eye_closed
                        : AppAssets.eye_open,
                  ),
                ),
              )
            : null,
        floatingLabelStyle: AppTextStyle.robotoregular.copyWith(
            fontSize: 18,
            color: (widget.formKey?.currentState?.validate() ?? true)
                ? AppColors.blueGradient
                : Colors.red),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: Colors.red),
        ),
        focusedErrorBorder: GradientOutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            focusedGradient: AppColors.logoGradient,
            unfocusedGradient: AppColors.logoGradient),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(color: AppColors.greyColor)),
        focusedBorder: GradientOutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            focusedGradient: AppColors.logoGradient,
            unfocusedGradient: AppColors.logoGradient),
      ),
    );
  }
}
