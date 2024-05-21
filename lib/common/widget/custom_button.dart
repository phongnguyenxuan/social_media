import 'package:blog/core/themes/color.dart';
import 'package:flutter/material.dart';

enum ButtonType { full, outline }

class CustomButton extends StatelessWidget {
  const CustomButton(
      {super.key,
      this.onTap,
      required this.child,
      this.padding,
      this.width,
      this.height,
      this.radius,
      this.boderWidth,
      this.buttonType});

  const CustomButton.full(
      {super.key,
      this.onTap,
      required this.child,
      this.padding,
      this.width,
      this.height,
      this.radius,
      this.boderWidth,
      this.buttonType = ButtonType.full});

  const CustomButton.outLine(
      {super.key,
      this.onTap,
      required this.child,
      this.padding,
      this.width,
      this.height,
      this.radius,
      this.boderWidth,
      this.buttonType = ButtonType.outline});

  final void Function()? onTap;
  final Widget child;
  final EdgeInsets? padding;
  final double? width;
  final double? height;
  final double? radius;
  final double? boderWidth;
  final ButtonType? buttonType;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? MediaQuery.of(context).size.width,
      height: height,
      padding: EdgeInsets.all(boderWidth ?? 2),
      decoration: BoxDecoration(
        gradient: AppColors.logoGradient,
        borderRadius: BorderRadius.circular(radius ?? 30),
      ),
      child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius ?? 30),
          ),
          child: Material(
              color:
                  (buttonType == ButtonType.full) ? Colors.transparent : null,
              borderRadius: BorderRadius.circular(radius ?? 30),
              child: InkWell(
                  onTap: onTap,
                  borderRadius: BorderRadius.circular(radius ?? 30),
                  child: Padding(
                    padding: padding ?? const EdgeInsets.all(15),
                    child: child,
                  )))),
    );
  }
}
