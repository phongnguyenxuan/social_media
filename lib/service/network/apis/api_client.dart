import 'package:blog/core/constants/preference_key.dart';
import 'package:blog/models/post_model.dart';
import 'package:blog/models/user_model.dart';
import 'package:blog/service/database/local_database_service.dart';
import 'package:blog/service/logger/logger.dart';
import 'package:blog/service/network/apis/api_endpoint.dart';
import 'package:blog/service/network/dio_client.dart';
import 'package:blog/service/network/network_exceptions.dart';
import 'package:dio/dio.dart';

class ApiClient {
  final DioClient dioClient = DioClient.instance;
  final SharedPreferencesManager sharedPreferencesManager =
      SharedPreferencesManager.instance;
  //============================= Auth ========================================
  Future<UserModel?> login(
      {required String email, required String password}) async {
    var request = {
      "email": email,
      "password": password,
    };
    Response response = await dioClient.post(ApiEndPoints.LOGIN, data: request);
    if (response.statusCode == 200) {
      UserModel result = UserModel.fromJson(response.data["data"]);
      await sharedPreferencesManager.setString(
          PreferenceKey.access_token, response.data["data"]["token"]);
      await sharedPreferencesManager.setString(
          PreferenceKey.refresh_token, response.data["data"]["refreshToken"]);
      await sharedPreferencesManager.setString(
          PreferenceKey.user_id, result.sId!);
      logSuccess("login success | data: ${result.toJson().toString()}");
      return result;
    } else {
      throw NetworkException(
          message: response.statusMessage, statusCode: response.statusCode);
    }
  }

  Future<UserModel?> register(
      {required String email,
      required String password,
      required String name}) async {
    var request = {
      "email": email,
      "password": password,
      "name": name,
    };
    Response response =
        await dioClient.post(ApiEndPoints.REGISTER, data: request);
    if (response.statusCode == 200) {
      UserModel result = UserModel.fromJson(response.data["data"]);
      await sharedPreferencesManager.setString(
          PreferenceKey.access_token, response.data["data"]["token"]);
      await sharedPreferencesManager.setString(
          PreferenceKey.refresh_token, response.data["data"]["refreshToken"]);
      await sharedPreferencesManager.setString(
          PreferenceKey.user_id, result.sId!);
      logSuccess("Register success | data: ${result.toJson().toString()}");
      return result;
    } else {
      throw NetworkException(
          message: response.statusMessage, statusCode: response.statusCode);
    }
  }

  Future<void> sendOTP({required String email}) async {
    var request = {
      "email": email,
    };
    Response response =
        await dioClient.post(ApiEndPoints.SEND_OTP, data: request);
    if (response.statusCode == 200) {
      logSuccess(response.data['data']);
    } else {
      throw NetworkException(
          message: response.statusMessage, statusCode: response.statusCode);
    }
  }

  //================================= USER =====================================
  Future<UserModel?> getUserInfo({required String id}) async {
    try {
      Response response = await dioClient.get(ApiEndPoints.USER_INFO(id));
      if (response.statusCode == 200) {
        UserModel userModel = UserModel.fromJson(response.data['data']);
        logSuccess('User info ${userModel.toJson().toString()}');
        return userModel;
      } else {
        throw NetworkException(
            message: response.statusMessage, statusCode: response.statusCode);
      }
    } on DioException catch (e) {
      logError(e);
      return null;
    }
  }

  //================================= POST =====================================
  Future<List<PostModel>?> getNewFeeds({
    required int page,
    required int limit,
  }) async {
    try {
      var query = {"page": page, "limit": limit};
      Response response =
          await dioClient.get(ApiEndPoints.NEW_FEEDS, queryParameters: query);
      if (response.statusCode == 200) {
        Iterable data = response.data["data"];
        List<PostModel> result = data
            .map(
              (e) => PostModel.fromJson(e),
            )
            .toList();
        logSuccess(result.length.toString());
        return result;
      } else {
        throw NetworkException(
            message: response.statusMessage, statusCode: response.statusCode);
      }
    } on DioException catch (e) {
      logError(e);
      return null;
    }
  }
}
