import 'package:flutter/material.dart';
import 'package:flutter_dingdian/local/local_config_repository.dart';
import 'package:get/get.dart';

import 'theme_state.dart';

class ThemeLogic extends GetxController {
  final state = ThemeState();

  changeThemeColor(Color color, String key) {
    state.colorKey = key;
    state.themeColor = color;
    LocalBookConfigRepository.saveTheme(key);
    update();
  }

  @override
  void onInit() async {
    super.onInit();

    state.colorKey = await LocalBookConfigRepository.getThemeKey();
    print(state.colorKey);
    state.themeColor = state.themeColorMap[state.colorKey]!;
  }
}
