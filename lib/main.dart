import 'package:chad_ai/configs/pages/main_page.dart';
import 'package:chad_ai/configs/routes/main_route.dart';
import 'package:chad_ai/configs/themes/main_theme.dart';
import 'package:chad_ai/global_bindings/global_binding.dart';
import 'package:chad_ai/utils/services/hive_service.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('id_ID', null);

  //hive init
  final dir = await getApplicationDocumentsDirectory();
  await Hive.initFlutter(dir.path);
  await Hive.openBox("chad_ai");
  HiveService.initHiveUser();

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
    // Optionally send error details to a remote server for debugging
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
        defaultTransition: Transition.native,
        getPages: MainPage.main,
        initialBinding: GlobalBinding(),
      ),
    );
  }
}
