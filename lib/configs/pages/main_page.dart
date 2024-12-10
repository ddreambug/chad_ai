import 'package:chad_ai/configs/routes/main_route.dart';
import 'package:chad_ai/features/chat/bindings/chat_bindings.dart';
import 'package:chad_ai/features/chat/sub_features/archive_detail/bindings/archive_detail_binding.dart';
import 'package:chad_ai/features/chat/sub_features/archive_detail/views/ui/archive_detail_view.dart';
import 'package:chad_ai/features/chat/sub_features/chat_detail/bindings/chat_detail_binding.dart';
import 'package:chad_ai/features/chat/sub_features/chat_detail/views/ui/chat_detail_view.dart';
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
      transition: Transition.fadeIn,
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
      binding: ChatBindings(),
    ),
    GetPage(
      name: MainRoute.chatDetails,
      page: () => const ChatDetailView(),
      transition: Transition.rightToLeft,
      binding: ChatDetailBinding(),
    ),
    GetPage(
      name: MainRoute.archiveDetails,
      page: () => const ArchiveDetailView(),
      transition: Transition.rightToLeft,
      binding: ArchiveDetailBinding(),
    ),
  ];
}
