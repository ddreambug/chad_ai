import 'package:chad_ai/shared/models/response_model.dart';
import 'package:chad_ai/utils/services/dio_service.dart';
import 'package:chad_ai/utils/services/sentry_service.dart';

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
  void updateAvatar() {}

  Future<ResponseModel> updateName({
    required String userId,
    required String newName,
  }) async {
    try {
      final response = await dio.put(
        '/users/$userId',
        data: {"username": newName},
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

  Future<ResponseModel> updateSecurity({
    required String userId,
    required String newSecurity,
    bool isPin = false,
  }) async {
    try {
      final response = await dio.put(
        '/users/$userId',
        data:
            isPin ? {'pin': int.parse(newSecurity)} : {'password': newSecurity},
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

  Future<ResponseModel> sendFeedback({
    required String userId,
    required String name,
    required String date,
    required String feedback,
  }) async {
    try {
      final response = await dio.post(
        '/users/$userId/feedback',
        data: {
          "createdAt": date,
          "name": name,
          "feedback": feedback,
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
