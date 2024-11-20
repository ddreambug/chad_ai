import 'package:get/get.dart';
import 'package:chad_ai/global_controllers/analytics_controller.dart';

class AnalyticsBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(
      AnalyticsController(),
    );
  }
}
