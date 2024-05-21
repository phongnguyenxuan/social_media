import 'package:get/get.dart';

class RegisterState {
  RxBool hidePassword = true.obs;
  RxBool hideConfirmPassword = true.obs;
  RxString nameValidator = "".obs;
  RxString mailValidator = "".obs;
  RxString passValidator = "".obs;
  RxString confirmValidator = "".obs;
  RegisterState() {}
}
