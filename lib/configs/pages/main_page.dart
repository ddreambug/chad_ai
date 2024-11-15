import 'package:chad_ai/configs/routes/main_route.dart';
import 'package:chad_ai/features/login/views/ui/login_view.dart';
import 'package:get/get.dart';

abstract class MainPage {
  static final main = [
    GetPage(
      name: MainRoute.login,
      page: () => const LoginView(),
    ),
  ];
}
