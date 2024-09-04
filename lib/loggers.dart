import 'package:logger/logger.dart';

final logger = Logger();

logInfo(dynamic message) {
  logger.i(message);
}

logErr(dynamic message, [StackTrace? st]) {
  logger.e(message);
  st != null ? logger.e('StackTrace : $st') : null;
}
