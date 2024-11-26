import 'package:get/get.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

class SentryService extends GetxService {
  SentryService._();

  static Future<void> handleAuthError(
    Object exception,
    StackTrace stacktrace,
  ) async {
    await Sentry.captureException(
      exception,
      stackTrace: stacktrace,
    );
  }
}
