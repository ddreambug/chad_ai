import 'dart:developer';

import 'package:chad_ai/features/login/repositories/login_repository.dart';
import 'package:chad_ai/global_controllers/global_controller.dart';
import 'package:chad_ai/utils/services/hive_service.dart';
import 'package:chad_ai/utils/services/sentry_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:panara_dialogs/panara_dialogs.dart';

class LoginController extends GetxController {
  static LoginController get to => Get.find();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  RxInt pinLength = 0.obs;
  var obscureStates = {
    'password': true,
    'rePassword': true,
    'pin': true,
  }.obs;

  void toggleObscure(String fieldKey) {
    obscureStates[fieldKey] = !(obscureStates[fieldKey] ?? true);
  }

  Future<bool> _checkInternetConnection() async {
    await GlobalController.to.checkConnection();
    return GlobalController.to.isConnect.value;
  }

  Future<void> _navigateToChat({String? socialEmail}) async {
    Get.offNamed('chat', arguments: socialEmail ?? emailController.text);
  }

  Future<void> signIn({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    EasyLoading.show();
    var userData = await LoginRepository().getUserData();
    if (userData.statusCode == 200) {
      final List users = userData.data;
      final user = users.firstWhere(
        (u) => u['email'] == email && u['password'] == password,
        orElse: () => null,
      );

      if (user != null) {
        EasyLoading.dismiss();
        _navigateToChat();
      } else {
        EasyLoading.dismiss();
        PanaraInfoDialog.show(
          // ignore: use_build_context_synchronously
          context,
          message: 'No User Found',
          buttonText: 'Ok',
          onTapDismiss: () {
            Get.back();
          },
          panaraDialogType: PanaraDialogType.error,
        );
        SentryService.handleAuthError('No User Found', StackTrace.current);
      }
    }
  }

  /// Social Sign-In
  Future<dynamic> signInWithGoogle(BuildContext context) async {
    if (!await _checkInternetConnection()) {
      Get.showSnackbar(
        GetSnackBar(title: 'No Internet'),
      );
      SentryService.handleAuthError('No Internet!', StackTrace.current);
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

      print('credential ok');

      FirebaseAuth.instance.signInWithCredential(credential);

      print('firebase signin ok');
      await LoginRepository().login(
        username: googleUser.displayName!,
        email: googleUser.email,
        password: '',
        pin: 1111,
        isGoogle: true,
      );

      print('loginrepo mockapi ok');

      await HiveService.addUser(
        nama: googleUser.displayName!,
        email: googleUser.email,
        password: 'default123',
        pin: 1111,
      );

      print('hiveservice ok');

      await _navigateToChat(socialEmail: googleUser.email);
    } catch (e, stacktrace) {
      await SentryService.handleAuthError(e, stacktrace);
    }
  }

  Future<dynamic> signInWithFacebook(BuildContext context) async {
    if (!await _checkInternetConnection()) {
      log('Internet is not connected');
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

        await _navigateToChat(socialEmail: facebookUser.message);
      } else {
        log('Facebook Login Failed: ${facebookUser.message}');
      }
    } catch (e, stacktrace) {
      await SentryService.handleAuthError(e, stacktrace);
    }
  }
}
