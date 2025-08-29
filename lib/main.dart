import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quizzi/views/pages/HomeScreen.dart';
import 'package:quizzi/views/pages/PLAYERSETUPSCREEN.dart';
import 'package:quizzi/views/pages/SETTINGSSCREEN.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (context, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Todo App avec GetX',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
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