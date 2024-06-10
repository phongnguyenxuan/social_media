import 'package:blog/modules/home/home_logic.dart';
import 'package:blog/modules/main/main_logic.dart';
import 'package:get/get.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MainLogic());
    Get.lazyPut(() => HomeLogic());
  }
}
