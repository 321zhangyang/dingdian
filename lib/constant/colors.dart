import 'package:flutter/material.dart';
import 'package:flutter_dingdian/theme/theme_logic.dart';
import 'package:get/get.dart';

//颜色常量 配置App中常用颜色 方便统一管理
class MyColors {
  static const Color app_main = Color(0xFF4688FA);
  static const Color dark_app_main = Color(0xFF3F7AE0);

  static const Color bg_color = Color(0xFFF9F9F9);
  static const Color dark_bg_color = Color(0xFF18191A);

  static const Color material_bg = Color(0xFFFFFFFF);
  static const Color dark_material_bg = Color(0xFF303233);

  static const Color text = Color(0xFF333333);
  static const Color dark_text = Color(0xFFB8B8B8);

  static const Color text_gray = Color(0xFF999999);
  static const Color dark_text_gray = Color(0xFF666666);

  static const Color text_gray_c = Color(0xFFcccccc);
  static const Color dark_button_text = Color(0xFFF2F2F2);

  static const Color bg_gray = Color(0xFFF6F6F6);
  static const Color dark_bg_gray = Color(0xFF1F1F1F);

  static const Color line = Color(0xFFEEEEEE);
  static const Color dark_line = Color(0xFF3A3C3D);

  static const Color red = Color(0xFFFF4759);
  static const Color dark_red = Color(0xFFE03E4E);

  static const Color text_disabled = Color(0xFFD4E2FA);
  static const Color dark_text_disabled = Color(0xFFCEDBF2);

  static const Color button_disabled = Color(0xFF96BBFA);
  static const Color dark_button_disabled = Color(0xFF83A5E0);

  static const Color unselected_item_color = Color(0xffbfbfbf);
  static const Color dark_unselected_item_color = Color(0xFF4D4D4D);

  static const Color bg_gray_ = Color(0xFFFAFAFA);
  static const Color dark_bg_gray_ = Color(0xFF242526);

  //主要字体颜色
  static const Color text_color = Color.fromRGBO(51, 51, 51, 1);

  static const Color text_one_color = Color.fromRGBO(100, 100, 100, 1);

  static const Color text_two_color = Color.fromRGBO(136, 136, 136, 1);

  static const Color text_blod_color = Color.fromRGBO(0, 0, 0, 1);

  static const Color text_normal_color = Color.fromRGBO(0, 0, 0, 0.85);

  static const Color text_address_color = Color.fromRGBO(0, 0, 0, 0.35);

  static const Color text_green_color = Color.fromRGBO(35, 179, 131, 1);

  //灰色字体颜色
  static const Color text_gray_color = Color.fromRGBO(153, 153, 153, 1);
  //主题绿色
  static const Color themeGreenColor = Color.fromRGBO(0, 201, 165, 1);
  //分割线
  static const Color segmentColor = Color.fromRGBO(0, 0, 0, 0.1);

  static const List<Color> gradientColors = [
    Color.fromRGBO(254, 90, 80, 1),
    Color.fromRGBO(254, 162, 94, 1),
  ];

  static const List<Color> gradientUnableColors = [
    Color.fromRGBO(254, 90, 80, 0.6),
    Color.fromRGBO(254, 162, 94, 0.6),
  ];

  static const Color tabbar_unselected_color = Color.fromRGBO(102, 102, 102, 1);

  static const Color tabbar_indicator_color = Color.fromRGBO(255, 220, 204, 1);

  static const Color home_title_color = Color.fromRGBO(252, 80, 76, 1);

  static const Color home_button_unSelectedColor =
      Color.fromRGBO(227, 228, 228, 1);

  //placeholder 颜色
  static const Color text_placeholder_color = Color.fromRGBO(194, 203, 209, 1);

  static const Color line_color = Color.fromRGBO(235, 235, 235, 1);

  //蓝色字体
  static const Color text_blue_color = button_enable_color;

  static const Color button_enable_color = Color.fromRGBO(0, 153, 255, 1);

  static const Color button_unable_color = Color.fromRGBO(0, 153, 255, 0.6);

  Color getThemeColor() {
    return Get.find<ThemeLogic>().state.themeColor;
  }
}
