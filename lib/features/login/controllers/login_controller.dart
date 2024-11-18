import 'package:chad_ai/configs/themes/main_color.dart';
import 'package:chad_ai/features/login/views/components/otp_dialog.dart';
import 'package:chad_ai/features/login/views/components/sign_up_dialog.dart';
import 'package:chad_ai/utils/enums/enum.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  static LoginController get to => Get.find();

  RxString emailValue = 'kosong@gmail.com'.obs;
  final TextEditingController otpTextController = TextEditingController();

  void onOtpComplete(BuildContext context, String value) {
    if (value == "1234") {
      otpTextController.clear();
      Get.back();
      Get.snackbar(
        "Success",
        "OTP code valid",
        backgroundColor: MainColor.black,
        duration: const Duration(seconds: 2),
      );
    }
  }

  void showDialog(BuildContext context, DialogType type) {
    if (type == DialogType.signup) {
      Get.dialog(SignUpDialog());
    } else if (type == DialogType.otp) {
      Get.dialog(OtpDialog());
    } else {
      print('wrong type');
    }
  }
}
