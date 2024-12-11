import 'package:chad_ai/features/chat/controllers/chat_controller.dart';
import 'package:chad_ai/shared/models/response_model.dart';
import 'package:chad_ai/utils/services/dio_service.dart';
import 'package:chad_ai/utils/services/sentry_service.dart';
import 'package:intl/intl.dart';

class ChatRepositories {
  final dio = DioService().getDio();

  /// Archived Chat
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

  Future<ResponseModel> deleteChat({
    required String userId,
    required String chatId,
  }) async {
    try {
      final response = await dio.delete(
        '/users/$userId/chat/$chatId',
      );

      if (response.statusCode == 200) {
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

  /// Profile
  void updateName() {}
  void updateAvatar() {}
  void updatePin() {}
  void updatePassword() {}

  Future<ResponseModel> sendFeedback({required String userId}) async {
    try {
      final response = await dio.post(
        '/users/$userId/feedback',
        data: {
          "createdAt": DateFormat('dd/MM/yyyy').format(DateTime.now()),
          "name": ChatController.to.currentName,
          "feedback": 'chatSession',
        },
      );

      if (response.statusCode == 200) {
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
