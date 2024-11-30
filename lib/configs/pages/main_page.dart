import 'package:chad_ai/configs/routes/main_route.dart';
import 'package:chad_ai/features/chat/bindings/chat_binding.dart';
import 'package:chad_ai/features/chat/views/ui/chat_detail_view.dart';
import 'package:chad_ai/features/chat/views/ui/chat_view.dart';
import 'package:chad_ai/features/login/bindings/login_binding.dart';
import 'package:chad_ai/features/login/views/ui/login_view.dart';
import 'package:chad_ai/features/sign_up/bindings/sign_up_binding.dart';
import 'package:chad_ai/features/sign_up/views/ui/sign_up_view.dart';
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
      name: MainRoute.signUp,
      page: () => const SignUpView(),
      binding: SignUpBinding(),
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
    ),
    GetPage(
      name: MainRoute.chat,
      page: () => const ChatView(),
      binding: ChatBinding(),
    ),
    GetPage(
      name: MainRoute.chatDetails,
      page: () => const ChatDetailView(),
      transition: Transition.rightToLeft,
    ),
  ];
}
