import 'package:chad_ai/configs/pages/main_page.dart';
import 'package:chad_ai/configs/routes/main_route.dart';
import 'package:chad_ai/configs/themes/main_theme.dart';
import 'package:chad_ai/firebase_options.dart';
import 'package:chad_ai/global_bindings/global_binding.dart';
import 'package:chad_ai/global_controllers/analytics_controller.dart';
import 'package:chad_ai/utils/services/hive_service.dart';
import 'package:email_otp/email_otp.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('id_ID', null);

  //email otp init
  EmailOTP.config(
    appName: 'Chad Ai',
    otpType: OTPType.numeric,
    otpLength: 4,
    emailTheme: EmailTheme.v6,
    appEmail: 'kamandaka25@gmail.com',
  );

  //hive init
  final dir = await getApplicationDocumentsDirectory();
  await Hive.initFlutter(dir.path);
  await Hive.openBox("chad_ai");
  HiveService.initHiveUser();

  //firebase analytic init
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  Get.put(AnalyticsController());

  //sentry init
  await SentryFlutter.init(
    (options) {
      options.dsn =
          'https://3568268c0ddc5887b9b0c185423fb1e2@o4507999775752192.ingest.us.sentry.io/4507999795478528';
      options.tracesSampleRate = 1.0;
    },
    appRunner: () => runApp(const MyApp()),
  );

  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.dumpErrorToConsole(details);
  };

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(414, 896),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => GetMaterialApp(
        title: 'Chad Ai',
        debugShowCheckedModeBanner: false,

        ///debugging purpose
        // initialRoute: MainRoute.mainMenu,
        initialRoute: MainRoute.login,
        theme: mainTheme,
        builder: EasyLoading.init(),
        defaultTransition: Transition.native,
        getPages: MainPage.main,
        initialBinding: GlobalBinding(),
      ),
    );
  }
}
