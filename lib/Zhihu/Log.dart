import 'package:logger/logger.dart';

/// <pre>
///      @author : Lichengze
///     @e-mail : lcz3466601343@163.com
///     @time   : 2021/05/18
///     @desc   :
///     version : 1.0
/// </pre>

class Log {
  static String TAG = "LCZ_LOG";
  static Logger _logger = Logger(
    printer: PrefixPrinter(PrettyPrinter()),
  );

  static void v(dynamic message) {
    _logger.v(TAG + message);
  }

  static void d(dynamic message) {
    _logger.d(TAG +message);
  }

  static void i(dynamic message) {
    _logger.i(TAG +message);
  }

  static void w(dynamic message) {
    _logger.w(TAG +message);
  }

  static void e(dynamic message) {
    _logger.e(TAG +message);
  }

  static void wtf(dynamic message) {
    _logger.wtf(TAG +message);
  }
}
