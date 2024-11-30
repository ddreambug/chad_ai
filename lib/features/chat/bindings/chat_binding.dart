import 'package:chad_ai/features/chat/controllers/chat_controller.dart';
import 'package:get/get.dart';

class ChatBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(
      ChatController(),
    );
  }
}
