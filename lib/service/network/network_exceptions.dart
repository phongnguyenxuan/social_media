class NetworkException implements Exception {
  String? message;
  int? statusCode;
  String? errorCode;

  NetworkException({this.message, this.statusCode, this.errorCode});

  @override
  String toString() {
    return '$errorCode';
  }
}
