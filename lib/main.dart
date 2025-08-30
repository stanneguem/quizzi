import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quizzi/views/pages/HomeScreen.dart';
import 'package:quizzi/views/pages/PLAYERSETUPSCREEN.dart';
import 'package:quizzi/views/pages/SETTINGSSCREEN.dart';

import 'controllers/themecontroler.dart';
import 'models/theme/clair.dart';
import 'models/theme/sombre.dart';

void main() {
  Get.put(ThemeController());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final ThemeController controller = Get.find<ThemeController>();
  MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (context, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Todo App avec GetX',
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: controller.isDark.value ? ThemeMode.light : ThemeMode.dark,
          initialRoute: "/",
          getPages: [
            GetPage(name: "/", page: () =>  Homescreen()),
            GetPage(name: "/setting", page: () =>  SETTINGSSCREEN()),
            GetPage(name: "/playersetup", page: () =>  GameSetupPage()),
          ],
        ) ;
      },
    );
  }
}