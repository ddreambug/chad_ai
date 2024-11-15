import 'package:get/get.dart';
import 'package:chad_ai/global_controllers/global_controller.dart';

class GlobalBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(GlobalController());
  }
}
