import 'package:chad_ai/shared/models/response_model.dart';
import 'package:chad_ai/utils/services/dio_service.dart';
import 'package:chad_ai/utils/services/sentry_service.dart';

class ChatRepositories {
  final dio = DioService().getDio();

  Future<ResponseModel> addChat({
    required String userId,
    required int chatId,
    required String date,
    required List<Map<String, dynamic>> chatSession,
  }) async {
    try {
      final response = await dio.post(
        '/users/$userId/chat',
        data: {
          "chatId": chatId,
          "date": date,
          "chatSession": chatSession,
        },
      );

      if (response.statusCode == 201) {
        return ResponseModel(
          statusCode: response.statusCode,
          data: response.data,
        );
      } else {
        return ResponseModel(
          statusCode: response.statusCode,
          data: response.data,
        );
      }
    } catch (e, stacktrace) {
      SentryService.handleAuthError(e, stacktrace);
      rethrow;
    }
  }

  Future<ResponseModel> getArchivedChat({required String userId}) async {
    try {
      final response = await dio.get('/users/$userId/chat');

      if (response.statusCode == 201) {
        return ResponseModel(
          statusCode: response.statusCode,
          data: response.data,
        );
      } else {
        return ResponseModel(
          statusCode: response.statusCode,
          data: response.data,
        );
      }
    } catch (e, stacktrace) {
      SentryService.handleAuthError(e, stacktrace);
      rethrow;
    }
  }
}
