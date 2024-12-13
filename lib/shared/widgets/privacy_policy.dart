import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';

class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({
    super.key,
    this.termsOfUse = false,
  });

  final bool termsOfUse;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          termsOfUse ? 'Terms of Use'.tr : 'Privacy & Policy'.tr,
        ),
      ),
      body: InAppWebView(
        initialUrlRequest: URLRequest(
          url: termsOfUse
              ? WebUri('https://github.com/ddreambug/chad_ai')
              : WebUri('https://venturo.id'),
        ),
      ),
    );
  }
}
