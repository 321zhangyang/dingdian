import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'theme_state.dart';

class ThemeLogic extends GetxController {
  final state = ThemeState();

  changeThemeColor(Color color, String key) {
    state.colorKey = key;
    state.themeColor = color;
    update();
  }
}
