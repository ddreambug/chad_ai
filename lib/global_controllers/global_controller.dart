import 'dart:io';
import 'package:get/get.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:chad_ai/configs/routes/main_route.dart';

class GlobalController extends GetxController {
  static GlobalController get to => Get.find();

  /// API
  var isStaging = false.obs;
  var baseUrl = 'https://67316a387aaf2a9aff10911d.mockapi.io';

  /// Location property
  RxString statusLocation = RxString('loading');
  RxnString messageLocation = RxnString();
  RxnDouble longitude = RxnDouble();
  RxnDouble latitude = RxnDouble();
  RxnString address = RxnString();

  /// Check Connection Variable
  var isConnect = false.obs;

  /// Check Connection Setting
  Future<void> checkConnection() async {
    try {
      final result = await InternetAddress.lookup('space.venturo.id');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        isConnect.value = true;
      }
    } on SocketException catch (exception, stackTrace) {
      isConnect.value = false;
      await Sentry.captureException(
        exception,
        stackTrace: stackTrace,
      );

      Get.offAllNamed(MainRoute.noConnection);
    }
  }

  Future<void> checkConnectionInPage() async {
    try {
      final result = await InternetAddress.lookup('space.venturo.id');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        isConnect.value = true;
      }
    } on SocketException catch (exception, stackTrace) {
      isConnect.value = false;
      await Sentry.captureException(
        exception,
        stackTrace: stackTrace,
      );
    }
  }

  void webView({bool termsOfUse = false}) {
    termsOfUse
        ? Get.toNamed(MainRoute.termsOfUse)
        : Get.toNamed(MainRoute.privacyPolicy);
  }
}
