import 'package:blog/modules/main/main_logic.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  final logic = Get.find<MainLogic>();
  final state = Get.find<MainLogic>().state;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Obx(() => Center(
                child: Text(state.user.value.name ?? ""),
              ))
        ],
      ),
    );
  }
}
