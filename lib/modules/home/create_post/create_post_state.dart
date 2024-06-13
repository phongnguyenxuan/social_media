import 'package:blog/models/user_model.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class CreatePostState {
  UserModel userModel = Get.arguments["user"];

  RxList<XFile> imageFiles = <XFile>[].obs;
  RxList<String> listImageUrl = <String>[].obs;

  CreatePostState() {}
}
