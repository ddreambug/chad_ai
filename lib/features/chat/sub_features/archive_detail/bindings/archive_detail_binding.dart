import 'package:chad_ai/features/chat/sub_features/archive_detail/controllers/archive_detail_controller.dart';
import 'package:get/get.dart';

class ArchiveDetailBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(
      ArchiveDetailController(),
    );
  }
}
