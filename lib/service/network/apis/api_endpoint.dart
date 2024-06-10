// ignore_for_file: constant_identifier_names, non_constant_identifier_names

class ApiEndPoints {
  //Base Url
  static const String BASE_URL = "https://social-media-api-qiyorie.vercel.app";

  //AUTH
  static const String LOGIN = "/auth/login";
  static const String REGISTER = "/auth/register";
  static const String SEND_OTP = "/auth/send-otp";
  static const String VERIFY_OTP = "/auth/verify-otp";
  static const String FORGOT_PASSWORD = "/auth/forgot-password";
  static const String RESET_PASSWORD = "/auth/reset-password";
  static const String REFRESH_TOKEN = "/auth/refresh-token";

  //USER
  static String USER_INFO(String id) => "/user/info?id=$id";

  //POST
  static const String NEW_FEEDS = "/post/news";
}
