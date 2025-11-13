import 'dart:io';
import 'package:flutter_base_project/core/constants/app_colors.dart';
import 'package:flutter_base_project/core/services/http_service.dart';
import 'package:flutter_base_project/core/utils/connectivity_checker.dart';
import 'package:flutter_base_project/core/utils/local_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'core/routes/app_pages.dart';
import 'core/routes/app_routes.dart';
import 'core/utils/initial_binding.dart';
import 'core/utils/local_data_service.dart';

const env = String.fromEnvironment('ENV', defaultValue: 'dev');

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env.$env');
  await _initializeServices();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, // transparent or your custom color
      statusBarIconBrightness: Brightness.dark, // Android
      statusBarBrightness: Brightness.light,    // iOS
    ),
  );

  runApp( ScreenUtilInit(
    minTextAdapt: true,
    splitScreenMode: true,
      designSize: const Size(375, 812),
    builder: (context,child)=>MyApp(),
  ));
}

Future<void> _initializeServices() async {
  // await Firebase.initializeApp(
  //   name: appName,
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
  await HttpService.httpService.init();
  await SharedPrefManager().init();
  await Get.putAsync<LocalDataService>(() => LocalDataService().init());
  Get.put(ConnectivityController());
  HttpOverrides.global = MyHttpOverrides();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => GetMaterialApp(
    debugShowCheckedModeBanner: false,
    initialBinding: InitialBinding(),
    theme: ThemeData(
      primaryColor: AppColors.primary,
      fontFamily: 'Poppins',
      scaffoldBackgroundColor: Colors.white
    ),
    initialRoute: AppRoutes.splash,
    getPages: AppPages.routes,
      );
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (cert, host, port) => true;
  }
}
