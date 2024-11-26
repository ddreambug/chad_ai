import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:chad_ai/utils/services/dio_service.dart';
import '../repositories/login_response_model.dart'; // Import the model class

class LoginRepository {
  final dio = DioService().getDio();

  Future<LoginResponseModel> login({
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

      // Map response to LoginResponse model
      return LoginResponseModel(
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
