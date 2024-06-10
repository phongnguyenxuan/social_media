import 'package:blog/common/widget/custom_icons/custom_icons_icons.dart';
import 'package:blog/core/themes/color.dart';
import 'package:blog/modules/main/main_logic.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../common/widget/bottom_navigation_bar/gbutton.dart';
import '../../common/widget/bottom_navigation_bar/custom_bottom_bar.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView>
    with SingleTickerProviderStateMixin, WidgetsBindingObserver {
  final logic = Get.find<MainLogic>();
  final state = Get.find<MainLogic>().state;

  @override
  void initState() {
    state.pageViewController = PageController();
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBackground,
      body: PageView(
        controller: state.pageViewController,
        onPageChanged: (value) {
          state.currentTab.value = value;
        },
        children: state.pageList,
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
            border: Border(
                top: BorderSide(
                    width: 1, color: AppColors.greyColor.withOpacity(0.6)))),
        child: SafeArea(
          child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15),
              child: Obx(
                () => CustomBottomNavigation(
                  hoverColor: Colors.grey[100]!,
                  gap: 8,
                  activeColor: AppColors.primaryColor,
                  iconSize: 20,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  duration: const Duration(milliseconds: 200),
                  color: AppColors.iconColor,
                  tabs: const [
                    BottomButton(
                      icon: CustomIcons.home_outline,
                      activeIcon: CustomIcons.home_soild,
                      iconActiveColor: AppColors.primaryColor,
                    ),
                    BottomButton(
                      icon: CustomIcons.save_outline,
                      activeIcon: CustomIcons.save_solid,
                      iconActiveColor: AppColors.primaryColor,
                    ),
                    BottomButton(
                      icon: CustomIcons.conversation_outline,
                      activeIcon: CustomIcons.conversation_soild,
                      iconActiveColor: AppColors.primaryColor,
                    ),
                    BottomButton(
                      icon: CustomIcons.profile_outline,
                      activeIcon: CustomIcons.profilee_soild,
                      iconActiveColor: AppColors.primaryColor,
                    ),
                  ],
                  selectedIndex: state.currentTab.value,
                  onTabChange: (index) =>
                      logic.onTabChange(selectTabIndex: index),
                ),
              )),
        ),
      ),
    );
  }
}
