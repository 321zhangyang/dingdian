import 'package:flutter/material.dart';
import 'package:flutter_dingdian/theme/theme_logic.dart';
import 'package:get/get.dart';

//颜色常量 配置App中常用颜色 方便统一管理
class MyColors {

  //主要字体颜色
  static const Color text_color = Color.fromRGBO(51, 51, 51, 1);
  //灰色字体颜色
  static const Color text_gray_color = Color.fromRGBO(153, 153, 153, 1);
  //分割线
  static const Color segmentColor = Color.fromRGBO(0, 0, 0, 0.1);

  Color getThemeColor() {
    return Get.find<ThemeLogic>().state.themeColor;
  }
}
