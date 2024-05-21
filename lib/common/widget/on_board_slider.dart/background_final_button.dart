import 'package:blog/common/widget/custom_button.dart';
import 'package:flutter/material.dart';

class FinishButtonStyle {
  final ShapeBorder? shape;

  final double? elevation;
  final double? focusElevation;
  final double? hoverElevation;
  final double? highlightElevation;
  final double? disabledElevation;

  final Color? foregroundColor;
  final Color? backgroundColor;
  final Color? focusColor;
  final Color? hoverColor;
  final Color? splashColor;

  const FinishButtonStyle({
    this.shape = const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(5.0),
      ),
    ),
    this.elevation = 0,
    this.focusElevation,
    this.hoverElevation,
    this.highlightElevation,
    this.disabledElevation,
    this.foregroundColor,
    this.backgroundColor,
    this.focusColor,
    this.hoverColor,
    this.splashColor,
  });
}

class BackgroundFinalButton extends StatelessWidget {
  final int currentPage;
  final PageController pageController;
  final int totalPage;
  final bool addButton;
  final Function? onPageFinish;
  final Function? onPageChange;
  final TextStyle buttonTextStyle;
  final String? buttonText;
  final bool hasSkip;
  final Icon skipIcon;
  final FinishButtonStyle? finishButtonStyle;

  const BackgroundFinalButton({
    super.key,
    required this.currentPage,
    required this.pageController,
    required this.totalPage,
    this.onPageFinish,
    this.buttonText,
    required this.buttonTextStyle,
    required this.addButton,
    required this.hasSkip,
    required this.skipIcon,
    this.finishButtonStyle = const FinishButtonStyle(),
    this.onPageChange,
  });

  @override
  Widget build(BuildContext context) {
    return addButton
        ? hasSkip
            ? AnimatedContainer(
                padding: currentPage == totalPage - 1
                    ? const EdgeInsets.symmetric(horizontal: 30)
                    : const EdgeInsets.all(0),
                width: currentPage == totalPage - 1
                    ? MediaQuery.of(context).size.width - 30
                    : 60,
                duration: const Duration(milliseconds: 100),
                child: currentPage == totalPage - 1
                    ? CustomButton.full(
                        onTap: () => onPageFinish?.call(),
                        child: buttonText == null
                            ? const SizedBox.shrink()
                            : Text(
                                buttonText!,
                                style: buttonTextStyle,
                                textAlign: TextAlign.center,
                                maxLines: 1,
                              ),
                      )
                    : CustomButton.full(
                        onTap: () {
                          onPageChange?.call();
                        },
                        child: skipIcon),
              )
            : Container(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                width: MediaQuery.of(context).size.width - 30,
                child: CustomButton.full(
                  onTap: () => onPageFinish?.call(),
                  child: buttonText == null
                      ? const SizedBox.shrink()
                      : Text(
                          buttonText!,
                          style: buttonTextStyle,
                          textAlign: TextAlign.center,
                          maxLines: 1,
                        ),
                ))
        : const SizedBox.shrink();
  }
}
