import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:chad_ai/utils/services/dio_service.dart';
import '../../../shared/models/response_model.dart';

class LoginRepository {
  final dio = DioService().getDio();

  Future<ResponseModel> login({
    required String username,
    required String email,
    required String password,
    String? avatar,
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
          "avatar": avatar,
          "isGoogle": isGoogle,
        },
      );

      return ResponseModel(
        statusCode: response.statusCode,
        data: response.data,
      );
    } catch (error, stackTrace) {
      await Sentry.captureException(
        error,
        stackTrace: stackTrace,
      );

      rethrow;
    }
  }

  Future<ResponseModel> getUserData() async {
    try {
      final response = await dio.get('/users');

      return ResponseModel(
        statusCode: response.statusCode,
        data: response.data,
      );
    } catch (error, stackTrace) {
      await Sentry.captureException(
        error,
        stackTrace: stackTrace,
      );

      rethrow;
    }
  }
}
