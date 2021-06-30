import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'theme_logic.dart';
import 'theme_state.dart';

/// @description:
/// @author 
/// @date: 2021/06/30 16:54:17
class ThemePage extends StatelessWidget {
  final ThemeLogic logic = Get.put(ThemeLogic());
  final ThemeState state = Get.find<ThemeLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
