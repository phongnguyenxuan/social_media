import 'package:logger/logger.dart';

var logger = Logger();

logError(dynamic message) => logger.e(message);

logSuccess(dynamic message) => logger.d(message);
