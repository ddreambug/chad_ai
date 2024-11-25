import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:chad_ai/utils/services/dio_service.dart';

class LoginRepository {
  final dio = DioService().getDio();

  //note<
  Future<Map<String, dynamic>> login({
    required String username,
    required String email,
    required String password,
    int pin = 1111,
    bool isGoogle = false,
  }) async {
    try {
      final response = await dio.post(
        '/users',
        data: {
          "username": username,
          "email": email,
          "password": password,
          "pin": pin,
          "isGoogle": isGoogle,
        },
      );

      return {
        "status_code": response.statusCode,
        "data": response.data,
      };
    } catch (error, stackTrace) {
      await Sentry.captureException(
        error,
        stackTrace: stackTrace,
      );

      rethrow;
    }
  }
}
