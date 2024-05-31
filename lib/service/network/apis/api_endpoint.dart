// ignore_for_file: constant_identifier_names

class ApiEndPoints {
  //Base Url
  static const String BASE_URL = "http://localhost:3001";

  //AUTH
  static const String LOGIN = "/auth/login";
  static const String REGISTER = "/auth/register";
  static const String SEND_OTP = "/auth/send-otp";
  static const String VERIFY_OTP = "/auth/verify-otp";
  static const String FORGOT_PASSWORD = "/auth/forgot-password";
  static const String RESET_PASSWORD = "/auth/reset-password";
  static const String REFRESH_TOKEN = "/auth/refresh-token";
}