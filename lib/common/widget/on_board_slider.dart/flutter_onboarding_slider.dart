// ignore_for_file: library_private_types_in_public_api

library flutter_onboarding_slider;

import 'package:blog/common/widget/on_board_slider.dart/background_controller.dart';
import 'package:blog/common/widget/on_board_slider.dart/background_final_button.dart';
import 'package:blog/common/widget/on_board_slider.dart/onboarding_navigation_bar.dart';
import 'package:blog/common/widget/on_board_slider.dart/page_offset_provider.dart';
import 'package:blog/core/themes/color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:provider/provider.dart';
import 'background_body.dart';

export 'background.dart';
export 'background_final_button.dart';

class OnBoardingSlider extends StatefulWidget {
  /// Number of total pages.
  final int totalPage;

  /// NavigationBars color.
  final Color headerBackgroundColor;

  /// The speed of the animation for the [background].
  final double speed;

  /// Background Color of whole screen apart from the NavigationBar.
  final Color? pageBackgroundColor;

  /// Background Gradient of whole screen apart from the NavigationBar.
  final Gradient? pageBackgroundGradient;

  /// Callback to be executed when clicked on the [finishButton].
  final Function? onFinish;

  /// NavigationBar trailing widget when on last screen.
  final Widget? trailing;

  /// NavigationBar trailing widget when not on last screen.
  final Widget? skipTextButton;

  /// The main content ont the screen displayed above the [background].
  final List<Widget> pageBodies;

  /// Callback to be executed when clicked on the last pages bottom button.
  final Function? trailingFunction;

  /// Style of the bottom button on the last page.
  final FinishButtonStyle? finishButtonStyle;

  /// Text inside last pages bottom button.
  final String? finishButtonText;

  /// Text style for text inside last pages bottom button.
  final TextStyle finishButtonTextStyle;

  /// Color of the bottom page indicators.
  final Color? controllerColor;

  /// Toggle bottom button.
  final bool addButton;

  /// Center [background].
  /// Do not pass [imageHorizontalOffset] when you turn this flag to true otherwise that will get ignored
  final bool centerBackground;

  /// Toggle bottom page controller visibilty.
  final bool addController;

  /// Defines the vertical offset of the [background].
  final double imageVerticalOffset;

  /// Defines the horizontal offset of the [background].
  /// Do not set [centerBackground] to true when you use this property otherwise this will get ignored
  final double imageHorizontalOffset;

  /// leading widget in the navigationBar.
  final Widget? leading;

  /// middle widget in the navigationBar.
  final Widget? middle;

  /// Whether has the floating action button to skip and the finish button
  final bool hasFloatingButton;

  /// Whether has the skip button in the bottom;
  final bool hasSkip;

  /// icon on the skip button
  final Icon skipIcon;

  /// is the indicator located on top of the screen
  final bool indicatorAbove;

  /// distance of indicator from bottom
  final double indicatorPosition;

  /// override the function for kip button in the navigator.
  final Function? skipFunctionOverride;

  final Function? onChange;

  final PageController pageController;

  const OnBoardingSlider({
    super.key,
    required this.totalPage,
    required this.headerBackgroundColor,
    required this.speed,
    required this.pageBodies,
    this.onFinish,
    this.trailingFunction,
    this.trailing,
    this.skipTextButton,
    this.pageBackgroundColor,
    this.pageBackgroundGradient,
    this.finishButtonStyle,
    this.finishButtonText,
    this.controllerColor,
    this.addController = true,
    this.centerBackground = false,
    this.addButton = true,
    this.imageVerticalOffset = 0,
    this.imageHorizontalOffset = 0,
    this.leading,
    this.middle,
    this.hasFloatingButton = true,
    this.hasSkip = true,
    this.finishButtonTextStyle = const TextStyle(
      fontSize: 20,
      color: Colors.white,
    ),
    this.skipIcon = const Icon(
      Icons.arrow_forward,
      color: Colors.white,
    ),
    this.indicatorAbove = false,
    this.indicatorPosition = 90,
    this.skipFunctionOverride,
    this.onChange,
    required this.pageController,
  });

  @override
  _OnBoardingSliderState createState() => _OnBoardingSliderState();
}

class _OnBoardingSliderState extends State<OnBoardingSlider> {
  // final PageController _pageController = PageController(initialPage: 0);

  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    bool keyboardIsOpen = WidgetsBinding.instance.window.viewInsets.bottom != 0;
    return ChangeNotifierProvider(
      create: (BuildContext context) =>
          PageOffsetNotifier(widget.pageController),
      child: Scaffold(
        floatingActionButton: Visibility(
          visible: !keyboardIsOpen,
          child: KeyboardVisibilityBuilder(builder: (context, visible) {
            return !visible
                ? BackgroundFinalButton(
                    buttonTextStyle: widget.finishButtonTextStyle,
                    skipIcon: widget.skipIcon,
                    addButton: widget.addButton,
                    currentPage: _currentPage,
                    pageController: widget.pageController,
                    totalPage: widget.totalPage,
                    onPageFinish: widget.onFinish,
                    finishButtonStyle: widget.finishButtonStyle,
                    buttonText: widget.finishButtonText,
                    hasSkip: widget.hasSkip,
                    onPageChange: widget.onChange,
                  )
                : Container();
          }),
        ),
        body: CupertinoPageScaffold(
          backgroundColor: AppColors.lightBackground,
          navigationBar: OnBoardingNavigationBar(
            skipFunctionOverride: widget.skipFunctionOverride,
            leading: widget.leading,
            middle: widget.middle,
            totalPage: widget.totalPage,
            currentPage: _currentPage,
            onSkip: _onSkip,
            headerBackgroundColor: widget.headerBackgroundColor,
            onFinish: widget.trailingFunction,
            finishButton: widget.trailing,
            skipTextButton: widget.skipTextButton,
          ),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: BackgroundBody(
                    controller: widget.pageController,
                    function: slide,
                    totalPage: widget.totalPage,
                    bodies: widget.pageBodies,
                  ),
                ),
                widget.addController
                    ? BackgroundController(
                        hasFloatingButton: widget.hasFloatingButton,
                        indicatorPosition: widget.indicatorPosition,
                        indicatorAbove: widget.indicatorAbove,
                        currentPage: _currentPage,
                        totalPage: widget.totalPage,
                        controllerColor: widget.controllerColor,
                      )
                    : const SizedBox.shrink(),
              ]),
        ),
      ),
    );
  }

  /// Slide to Next Page.
  void slide(int page) {
    setState(() {
      _currentPage = page;
    });
  }

  /// Skip to last Slide.
  void _onSkip() {
    widget.pageController.jumpToPage(widget.totalPage - 1);
    setState(() {
      _currentPage = widget.totalPage - 1;
    });
  }
}
