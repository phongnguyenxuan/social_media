import 'package:blog/modules/home/create_post/create_post_state.dart';
import 'package:blog/service/logger/logger.dart';
import 'package:blog/service/network/apis/api_client.dart';
import 'package:blog/service/network/dio_client.dart';
import 'package:dio/dio.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:image_picker/image_picker.dart';

class CreatePostLogic extends GetxController {
  final state = CreatePostState();
  final imagePicker = ImagePicker();
  final DioClient dioClient = DioClient.instance;
  ApiClient apiClient = ApiClient();

  @override
  onReady() {
    if (state.typeCreate == "image") {
      pickImage();
    }
    super.onReady();
  }

  Future<void> pickImage() async {
    try {
      final List<XFile> pickedFiles = await imagePicker.pickMultiImage();
      if (pickedFiles.isNotEmpty) {
        state.imageFiles.value = pickedFiles;
        state.isValid.value = true;
      }
    } catch (e) {
      logError(e);
    }
  }

  //upload image to Cloudinary
  Future<String> _uploadImage(XFile imageFile) async {
    FormData formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(imageFile.path,
          filename: imageFile.name),
      'upload_preset': 'sxicpbes',
      'folder': 'posts'
    });

    try {
      final response = await dioClient.uploadImage("", data: formData);
      if (response.statusCode == 200) {
        return response.data['secure_url'];
      } else {
        throw Exception('Failed to upload image');
      }
    } on DioException catch (e) {
      logError("Upload error: ${e.response?.data}");
      rethrow;
    }
  }

  Future<void> uploadImage() async {
    try {
      if (state.imageFiles.isEmpty) {
        return;
      } else {
        List<String> imagesUrl = [];
        for (XFile imageFile in state.imageFiles) {
          String imageUrl = await _uploadImage(imageFile);
          imagesUrl.add(imageUrl);
        }
        state.listImageUrl.value = imagesUrl;
        logSuccess("Uploaded Image URLs: $imagesUrl");
      }
    } catch (e) {
      logError(e);
    }
  }

  Future<void> createPost() async {
    if (state.imageFiles.isNotEmpty) {
      EasyLoading.show();
      await uploadImage().then(
        (value) async {
          Map<String, dynamic> data = {
            "content": state.contentController.text,
            "images": state.listImageUrl,
          };
          int result = await apiClient.createPost(data: data);
          EasyLoading.dismiss();
          if (result == 200) {
            logSuccess("success create post");
          } else {
            logError("create fail");
          }
        },
      );
    } else {
      EasyLoading.show();
      Map<String, dynamic> data = {
        "content": state.contentController.text,
        "images": [],
      };
      int result = await apiClient.createPost(data: data);
      EasyLoading.dismiss();
      if (result == 200) {
        logSuccess("success create post");
      } else {
        logError("create fail");
      }
    }
  }

  void validatePost(String content) {
    if (state.imageFiles.isNotEmpty) {
      state.isValid.value = true;
    } else {
      if (content.isNotEmpty) {
        state.isValid.value = true;
      } else {
        state.isValid.value = false;
      }
    }
  }
}
