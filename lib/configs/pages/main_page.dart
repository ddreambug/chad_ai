import 'package:chad_ai/configs/routes/main_route.dart';
import 'package:chad_ai/features/login/bindings/login_bindings.dart';
import 'package:chad_ai/features/login/views/ui/login_view.dart';
import 'package:chad_ai/shared/widgets/privacy_policy.dart';
import 'package:get/get.dart';

abstract class MainPage {
  static final main = [
    GetPage(
      name: MainRoute.login,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: MainRoute.privacyPolicy,
      page: () => const PrivacyPolicy(),
    ),
    GetPage(
      name: MainRoute.termsOfUse,
      page: () => const PrivacyPolicy(
        termsOfUse: true,
      ),
    )
  ];
}
