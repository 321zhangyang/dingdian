import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'theme_state.dart';

class ThemeLogic extends GetxController {
  final state = ThemeState();

  changeThemeColor(Color color) {
    state.themeColor = color;
    update();
  }
}
