import 'package:blog/core/themes/color.dart';
import 'package:blog/modules/main/main_logic.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final mainLogic = Get.find<MainLogic>();
  final mainState = Get.find<MainLogic>().state;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBackground,
    );
  }
}
