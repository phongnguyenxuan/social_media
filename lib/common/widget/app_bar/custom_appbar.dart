import 'package:blog/common/widget/custom_icons/custom_icons_icons.dart';
import 'package:blog/common/widget/logo.dart';
import 'package:blog/core/themes/color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum AppbarType { normal, logo }

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final AppbarType type;
  final Widget? title;
  final bool? centerTitle;
  final List<Widget>? actions;
  final double? elevation;
  const CustomAppBar(
      {super.key,
      required this.type,
      this.title,
      this.centerTitle,
      this.actions,
      this.elevation});

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
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                child: Row(
                  children: [
                    const Logo(),
                    const Spacer(),
                    IconButton(
                        onPressed: () {}, icon: const Icon(CustomIcons.search))
                  ],
                ),
              )),
        );
      case AppbarType.normal:
        return AppBar(
          backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
          elevation: elevation ?? 0,
          title: title,
          centerTitle: centerTitle,
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            splashRadius: 20,
            icon: const Icon(
              CustomIcons.back,
              color: Colors.black,
              size: 20,
            ),
          ),
          actions: actions,
        );
    }
  }

  @override
  Size get preferredSize => Size.fromHeight(
      (type == AppbarType.logo) ? (kToolbarHeight + 25) : kToolbarHeight);
}
