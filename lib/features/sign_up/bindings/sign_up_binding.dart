import 'package:chad_ai/features/sign_up/controllers/sign_up_controller.dart';
import 'package:get/get.dart';

class SignUpBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(
      SignUpController(),
    );
  }
}
