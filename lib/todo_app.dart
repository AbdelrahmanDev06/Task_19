import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/login/login_screen.dart';
import 'package:flutter_application_1/features/splash/splash_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(420, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MaterialApp(
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        title: 'Todo App',
        theme: ThemeData(scaffoldBackgroundColor: Colors.white),
        home: const SplashScreen(),
      ),
    );
  }
}
