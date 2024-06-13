import 'package:blog/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class CreatePostState {
  UserModel userModel = Get.arguments["user"];
  String typeCreate = Get.arguments["type"];
  RxList<XFile> imageFiles = <XFile>[].obs;
  RxList<String> listImageUrl = <String>[].obs;
  TextEditingController contentController = TextEditingController();
  RxBool isValid = false.obs;

  CreatePostState() {}
}
