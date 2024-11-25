import 'package:chad_ai/configs/themes/main_color.dart';
import 'package:chad_ai/features/login/repositories/login_repository.dart';
import 'package:chad_ai/features/login/views/components/otp_dialog.dart';
import 'package:chad_ai/features/login/views/components/sign_up_dialog.dart';
import 'package:chad_ai/global_controllers/global_controller.dart';
import 'package:chad_ai/utils/enums/enum.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:email_otp/email_otp.dart';

class LoginController extends GetxController {
  static LoginController get to => Get.find();

  RxString emailValue = ''.obs;
  RxString otpValue = ''.obs;
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

  void toggleObscure(String fieldKey) {
    obscureStates[fieldKey] = !(obscureStates[fieldKey] ?? true);
  }

  Future<void> _handleAuthError(
    Object exception,
    StackTrace stacktrace,
  ) async {
    await Sentry.captureException(
      exception,
      stackTrace: stacktrace,
    );
  }

  Future<bool> _checkInternetConnection() async {
    await GlobalController.to.checkConnection();
    return GlobalController.to.isConnect.value;
  }

  Future<void> _navigateToChat() async {
    Get.offNamed('chat');
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

  /// Email OTP validation
  Future<void> sendEmailOtp() async {
    LoginController.to.emailValue.value =
        LoginController.to.emailController.text;

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
        var response = await LoginRepository().login(
          username: usernameController.text,
          email: emailController.text,
          password: passwordController.text,
          pin: int.parse(pinController.text),
        );

        if (response['status_code'] == 201) {
          addUser(
            nama: usernameController.text,
            email: emailController.text,
            password: passwordController.text,
            pin: int.parse(pinController.text),
          );

          otpTextController.clear();
          Get.back();
          Get.back();
          //   Get.until((route) => Get.currentRoute == '/login');

          Get.snackbar(
            "Success",
            "Registration Success",
            backgroundColor: MainColor.black,
            duration: const Duration(seconds: 2),
          );
        }
      } catch (e, stacktrace) {
        _handleAuthError(e, stacktrace);
      }
    }
  }

  /// Social Sign-In
  Future<dynamic> signInWithGoogle(BuildContext context) async {
    if (!await _checkInternetConnection()) {
      print('Internet is not connected');
      return;
    }

    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) return "modal dialog closed";

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);

      await LoginRepository().login(
        username: googleUser.displayName!,
        email: googleUser.email,
        password: '',
        pin: 1111,
        isGoogle: true,
      );

      await _navigateToChat();
    } catch (e, stacktrace) {
      await _handleAuthError(e, stacktrace);
    }
  }

  Future<dynamic> signInWithFacebook(BuildContext context) async {
    if (!await _checkInternetConnection()) {
      print('Internet is not connected');
      return;
    }

    try {
      final LoginResult facebookUser = await FacebookAuth.instance.login();

      if (facebookUser.status == LoginStatus.success) {
        final OAuthCredential facebookAuthCredential =
            FacebookAuthProvider.credential(
          facebookUser.accessToken!.tokenString,
        );

        await FirebaseAuth.instance
            .signInWithCredential(facebookAuthCredential);

        await _navigateToChat();
      } else {
        print('Facebook Login Failed: ${facebookUser.message}');
      }
    } catch (e, stacktrace) {
      await _handleAuthError(e, stacktrace);
    }
  }

  /// Store user data in the Hive box
  Future<void> addUser({
    required String nama,
    required String email,
    required String password,
    required int pin,
  }) async {
    var box = Hive.box('chad_ai');

    await box.put('username', nama);
    await box.put('email', email);
    await box.put('password', password);
    await box.put('pin', pin);
  }
}
