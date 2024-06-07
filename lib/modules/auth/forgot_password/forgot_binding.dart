import 'package:blog/modules/auth/forgot_password/forgot_logic.dart';
import 'package:get/get.dart';

class ForgotPasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ForgotPasswordLogic());
  }
}
