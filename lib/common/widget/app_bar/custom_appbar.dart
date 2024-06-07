import 'package:blog/common/widget/custom_icons/custom_icon_icons.dart';
import 'package:blog/common/widget/logo.dart';
import 'package:blog/core/themes/color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum AppbarType { normal, logo }

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final AppbarType type;
  const CustomAppBar({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    switch (type) {
      case AppbarType.logo:
        return AppBar(
          backgroundColor: AppColors.lightBackground,
          automaticallyImplyLeading: false,
          elevation: 0,
          bottom: PreferredSize(
              preferredSize: preferredSize,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                child: Row(
                  children: [
                    const Logo(),
                    const Spacer(),
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.search_rounded))
                  ],
                ),
              )),
        );
      case AppbarType.normal:
        return AppBar(
          backgroundColor: AppColors.lightBackground,
          elevation: 0,
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              splashRadius: 25,
              icon: const Icon(
                CustomIcon.back_icon,
                color: Colors.black,
                size: 45,
              )),
        );
    }
  }

  @override
  Size get preferredSize => Size.fromHeight(
      (type == AppbarType.logo) ? (kToolbarHeight + 50) : kToolbarHeight);
}