import 'package:chad_ai/configs/routes/main_route.dart';
import 'package:chad_ai/configs/themes/main_color.dart';
import 'package:chad_ai/features/login/views/components/otp_dialog.dart';
import 'package:chad_ai/features/login/views/components/sign_up_dialog.dart';
import 'package:chad_ai/global_controllers/global_controller.dart';
import 'package:chad_ai/utils/enums/enum.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

class LoginController extends GetxController {
  static LoginController get to => Get.find();

  RxString emailValue = 'kosong@gmail.com'.obs;
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController rePasswordController = TextEditingController();
  TextEditingController pinController = TextEditingController();
  TextEditingController otpTextController = TextEditingController();
  TextEditingController chatInputController = TextEditingController();
  RxInt pinLength = 0.obs;
  var obscureStates = {
    'password': true,
    'rePassword': true,
    'pin': true,
  }.obs;

  void toggleObscure(String fieldKey) {
    obscureStates[fieldKey] = !(obscureStates[fieldKey] ?? true);
  }

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

  void clearControllerState() {
    usernameController.clear();
    emailController.clear();
    passwordController.clear();
    rePasswordController.clear();
    pinController.clear();
    otpTextController.clear();
    chatInputController.clear();
    obscureStates['password'] = true;
    obscureStates['rePassword'] = true;
    obscureStates['pin'] = true;
  }

  Future<dynamic> signInWithGoogle(BuildContext context) async {
    await GlobalController.to.checkConnection();

    if (GlobalController.to.isConnect.value == true) {
      print('masuk1');
      try {
        final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
        if (googleUser == null) return "modal dialog closed";

        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;

        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        print('goggleauth done');
        print('AccessToken: ${googleAuth.accessToken}');
        print('IDToken: ${googleAuth.idToken}');

        try {
          UserCredential userData =
              await FirebaseAuth.instance.signInWithCredential(
            credential,
          );
          print('firebaseauth done');
          Get.offNamed('chat');
        } catch (e) {
          print('FirebaseAuth error: $e');
        }

        // print('success login, data: $userData');
        // var response = await LoginRepository().login(
        //   userData.user!.email!,
        //   userData.user!.displayName!,
        //   true,
        // );

        // if (response['status_code'] == 200) {
        //   await addUser(
        //     nama: userData.user!.displayName!,
        //     tanggalLahir: '12/12/2012',
        //     nomorTelepon: '08224111400',
        //     alamatEmail: userData.user!.email!,
        //     pin: '111111',
        //     foto: userData.user!.photoURL!,
        //     token: userData.credential!.token.toString(),
        //   );
        //   Get.offNamed('/search-location');
        // } else if (response['status_code'] == 422) {
        //   Get.snackbar(
        //     "Error",
        //     "Server error",
        //     backgroundColor: MainColor.black,
        //     duration: const Duration(seconds: 2),
        //   );
        // } else {
        //   Get.snackbar(
        //     "Try again",
        //     "Error might occured",
        //     backgroundColor: MainColor.black,
        //     duration: const Duration(seconds: 2),
        //   );
        // }

        // return response;
      } catch (exception, stacktrace) {
        await Sentry.captureException(
          exception,
          stackTrace: stacktrace,
        );
      }
    } else if (GlobalController.to.isConnect.value == false) {
      print('internet is not connected');
    }
  }
}
