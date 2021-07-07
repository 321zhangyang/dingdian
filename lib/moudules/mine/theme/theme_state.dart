import 'package:flutter/material.dart';

class ThemeState {
  Color themeColor = Colors.blue;
  Map<String, Color> themeColorMap = {
    '大地棕': Color.fromRGBO(200, 142, 94, 1),
    '经典蓝':  Color.fromRGBO(0, 163, 237, 1),
    '活力红':  Color.fromRGBO(219, 25, 21, 1),
    '酷炫黑':  Color.fromRGBO(40, 40, 40, 1),
    '新鲜橙':  Color.fromRGBO(255, 90, 30, 1),
    '健康绿':  Color.fromRGBO(59, 174, 94, 1),
    '高贵紫':  Color.fromRGBO(84, 29, 121, 1),
    '可爱粉':  Color.fromRGBO(255, 103, 142, 1),
    '自然青':  Color.fromRGBO(0, 175, 137, 1),
    '魅力黄':  Color.fromRGBO(255, 192, 83, 1),
  };
  String? colorKey;
  themeState() {

  }
}
