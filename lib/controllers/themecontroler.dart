import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../models/theme/clair.dart';
import '../models/theme/sombre.dart';

class ThemeController extends GetxController {
  RxBool isDark = true.obs;

  ThemeData get theme => isDark.value ? darkTheme : lightTheme;

  void toggleTheme() {
    isDark.value = !isDark.value;
    Get.changeTheme(theme);
  }
}
