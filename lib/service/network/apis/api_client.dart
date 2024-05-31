import 'package:blog/core/constants/preference_key.dart';
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
  //Auth
  Future<UserModel?> login(
      {required String email, required String password}) async {
    try {
      var request = {
        "email": email,
        "password": password,
      };
      Response response =
          await dioClient.post(ApiEndPoints.LOGIN, data: request);
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
    } catch (e) {
      logError(e);
    }
    return null;
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
}
