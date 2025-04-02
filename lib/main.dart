import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_getx_auth_crud/firebase_options.dart';
import 'package:firebase_getx_auth_crud/screens/auth_screens/login_screen/login_screen.dart';
import 'package:firebase_getx_auth_crud/screens/auth_screens/splash_screen/splash_screen.dart';
import 'package:firebase_getx_auth_crud/utils/app_fonts.dart';
import 'package:firebase_getx_auth_crud/utils/theme_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'routes/index.dart';
import 'utils/app_theme.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      builder: (context, child) {
        ErrorWidget.builder = (errorDetails) {
          return const CustomFlutterErrorWidget();
        };
        return child!;
      },
      debugShowCheckedModeBanner: false,
      locale: const Locale('en', 'US'),
      fallbackLocale: const Locale('en', 'US'),
      title: Fonts.appName.tr,
home: SplashScreen(),
      getPages: appRoute.getPages,
      theme: AppTheme.fromType(ThemeType.light).themeData,
      darkTheme: AppTheme.fromType(ThemeType.dark).themeData,
      themeMode: ThemeService().theme,
    );
  }
}


class CustomFlutterErrorWidget extends StatelessWidget {
  const CustomFlutterErrorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        children: [

          Text(
            "An error occurred. Please try again later",
            style: TextStyle(fontSize: 14.0),
          ),
        ],
      ),
    );
  }
}