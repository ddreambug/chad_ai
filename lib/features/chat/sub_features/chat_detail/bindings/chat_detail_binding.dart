import 'package:chad_ai/features/chat/sub_features/chat_detail/controllers/chat_detail_controller.dart';
import 'package:get/get.dart';

class ChatDetailBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(
      ChatDetailController(),
    );
  }
}
