import 'package:get/get.dart';

import '../modules/auth/login/login_logic.dart';

class AppBinding extends Bindings {
  @override
  Future<void> dependencies() async {
    injectService();
  }

  void injectService() {
    Get.lazyPut(() => LoginLogic());
  }
}
