import 'package:blog/core/constants/preference_key.dart';
import 'package:blog/routes/app_routes.dart';
import 'package:blog/service/logger/logger.dart';
import 'package:blog/service/network/apis/api_endpoint.dart';
import 'package:dio/dio.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DioClient {
  // dio instance
  static final DioClient instance = DioClient._internal();

  late final Dio _dio;
  late final SharedPreferences _sharedPreferences;

  Dio get dio => _dio;

  factory DioClient() {
    return instance;
  }

  DioClient._internal() {
    _dio = Dio(
      BaseOptions(
        baseUrl: ApiEndPoints.BASE_URL,
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
      ),
    );

    SharedPreferences.getInstance().then((value) {
      _sharedPreferences = value;
      _setupInterceptors();
    });
  }

  void _setupInterceptors() {
    // Add interceptors if needed
    _dio.interceptors
        .add(InterceptorsWrapper(onRequest: (options, handler) async {
      String? accessToken =
          _sharedPreferences.getString(PreferenceKey.access_token);
      options.headers['Authorization'] = 'Bearer $accessToken';
      return handler.next(options);
    }, onError: (error, handler) async {
      if (error.response?.statusCode == 401 &&
          error.requestOptions.path != ApiEndPoints.REFRESH_TOKEN) {
        if (_sharedPreferences.getString(PreferenceKey.refresh_token) != null) {
          await refreshToken();
          try {
            var res = await _retry(error.requestOptions);
            logError('Retry res = $res');
            if (res is Response) {
              logError('Retry res instance of Response');
              return handler.resolve(res);
            } else {
              Response response = Response(
                  requestOptions: error.requestOptions,
                  statusCode: res['statusCode'],
                  statusMessage: res['message'],
                  data: res);
              response.statusCode = res['statusCode'];
              response.statusMessage = res['message'];
              handler.resolve(response);
            }
          } catch (err) {
            if (err is DioException) {
              handler.next(err);
            }
          }
        }
      } else {
        return handler.next(error);
      }
    }));
  }

  Future<dynamic> _retry(RequestOptions requestOptions) async {
    final options =
        Options(method: requestOptions.method, headers: requestOptions.headers);
    try {
      var res = await request(requestOptions.path,
          data: requestOptions.data,
          queryParameters: requestOptions.queryParameters,
          options: options);
      return res;
    } catch (err) {
      logError('Rethru error ${err.toString()}');
      rethrow;
    }
  }

  Future<dynamic> refreshToken() async {
    try {
      final refreshToken =
          _sharedPreferences.getString(PreferenceKey.refresh_token);
      _sharedPreferences.setString(PreferenceKey.access_token, refreshToken!);

      Response response = await _dio.post(ApiEndPoints.REFRESH_TOKEN);
      if (response.statusCode == 200) {
        await _sharedPreferences.setString(
            PreferenceKey.access_token, response.data['data']['accessToken']);
        _sharedPreferences.setString(
            PreferenceKey.refresh_token, response.data['data']['refreshToken']);
      }
    } catch (e) {
      _sharedPreferences.remove(PreferenceKey.access_token);
      _sharedPreferences.remove(PreferenceKey.refresh_token);
      Get.offAllNamed(AppRoutes.LOGIN);
    }
  }

  // Get:-----------------------------------------------------------------------
  Future<dynamic> get(
    String uri, {
    Map<String, dynamic>? queryParameters,
    dynamic data,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final Response response = await _dio.get(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  // Post:----------------------------------------------------------------------
  Future<dynamic> post(
    String uri, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final Response response = await _dio.post(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  // Delete:--------------------------------------------------------------------
  Future<dynamic> delete(
    String uri, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final Response response = await _dio.delete(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  // Request:--------------------------------------------------------------------
  Future<dynamic> request(
    String uri, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final Response response = await _dio.request(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      return response.data;
    } catch (e) {
      rethrow;
    }
  }
}
