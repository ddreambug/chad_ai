import 'package:chad_ai/utils/enums/enum.dart';
import 'package:get/get.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class UtilityService extends GetxService {
  UtilityService._();

  static String extractMessageText(
    ChatSession chatSession,
    int chatOrder,
    ChatDataType targetType,
  ) {
    var chatHistory = chatSession.history.toList();

    if (targetType == ChatDataType.role) {
      return chatHistory[chatOrder].role!;
    } else {
      return chatHistory[chatOrder]
          .parts
          .whereType<TextPart>()
          .map<String>((e) => e.text)
          .join('');
    }
  }
}
