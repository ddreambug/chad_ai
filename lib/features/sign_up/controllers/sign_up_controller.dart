import 'dart:developer';

import 'package:chad_ai/configs/themes/main_color.dart';
import 'package:chad_ai/features/login/controllers/login_controller.dart';
import 'package:chad_ai/features/sign_up/repositories/sign_up_repository.dart';
import 'package:chad_ai/features/sign_up/views/components/otp_dialog.dart';
import 'package:chad_ai/features/sign_up/views/ui/sign_up_view.dart';
import 'package:chad_ai/utils/enums/enum.dart';
import 'package:chad_ai/utils/services/hive_service.dart';
import 'package:chad_ai/utils/services/sentry_service.dart';
import 'package:email_otp/email_otp.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController {
  static SignUpController get to => Get.find();

  RxString emailValue = ''.obs;
  RxString otpValue = ''.obs;
  final FocusNode focusNode = FocusNode();
  final RxBool isFocused = false.obs;
  final RxString? errorText = RxString('');

  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController rePasswordController = TextEditingController();
  TextEditingController pinController = TextEditingController();
  TextEditingController otpTextController = TextEditingController();
  TextEditingController chatInputController = TextEditingController();

  void clearControllerState() {
    usernameController.clear();
    emailController.clear();
    passwordController.clear();
    rePasswordController.clear();
    pinController.clear();
    otpTextController.clear();
    chatInputController.clear();
    LoginController.to.obscureStates['password'] = true;
    LoginController.to.obscureStates['rePassword'] = true;
    LoginController.to.obscureStates['pin'] = true;
  }

  void showDialog(BuildContext context, DialogType type) {
    if (type == DialogType.signup) {
      Get.dialog(SignUpView());
    } else if (type == DialogType.otp) {
      Get.dialog(OtpDialog());
    } else {
      log('wrong type');
    }
  }

  /// Email OTP validation
  Future<void> sendEmailOtp() async {
    emailValue.value = emailController.text;

    EasyLoading.show();
    var otpToken = await EmailOTP.sendOTP(email: emailValue.value);

    if (otpToken) {
      otpValue.value = EmailOTP.getOTP()!;
      Get.snackbar(
        "Check your email",
        "OTP has been sent!",
        backgroundColor: MainColor.black,
        duration: const Duration(seconds: 2),
      );
      EasyLoading.dismiss();
    } else {
      Get.snackbar(
        "Failed",
        "Error Occured. OTP is not sent",
        backgroundColor: MainColor.black,
        duration: const Duration(seconds: 2),
      );
    }
  }

  void onOtpComplete(BuildContext context, String value) async {
    if (value == EmailOTP.getOTP()) {
      try {
        var userData = await SignUpRepository().getUserData();
        if (userData.statusCode == 200) {
          final List users = userData.data;
          final user = users.firstWhere(
            (u) =>
                u['email'] == emailController.text &&
                u['password'] == passwordController.text,
            orElse: () => null,
          );

          if (user == null) {
            var response = await SignUpRepository().signUp(
              username: usernameController.text,
              email: emailController.text,
              password: passwordController.text,
              pin: int.parse(pinController.text),
            );

            if (response.statusCode == 201) {
              HiveService.addUser(
                nama: usernameController.text,
                email: emailController.text,
                password: passwordController.text,
                pin: int.parse(pinController.text),
              );

              otpTextController.clear();
              Get.until((route) => Get.currentRoute == '/login');

              Get.snackbar(
                "Success",
                "Registration Success",
                backgroundColor: MainColor.black,
                duration: const Duration(seconds: 2),
              );
            }
          } else {
            otpTextController.clear();
            Get.until((route) => Get.currentRoute == '/login');
          }
        }
      } catch (e, stacktrace) {
        SentryService.handleAuthError(e, stacktrace);
      }
    }
  }
}
