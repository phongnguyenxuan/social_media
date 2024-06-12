import 'package:blog/modules/home/create_post/create_post_logic.dart';
import 'package:get/get.dart';

class CreatePostBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(CreatePostLogic());
  }
}
