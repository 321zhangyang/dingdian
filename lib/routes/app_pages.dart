import 'package:flutter_dingdian/moudules/tabbar/tabbar_page.dart';
import 'package:flutter_dingdian/moudules/theme.dart';
import 'package:flutter_dingdian/routes/app_routes.dart';
import 'package:get/route_manager.dart';

abstract class AppPages {
  static final pages = [
    GetPage(
      name: Routes.TABBAR,
      page: () => TabBarPage(),
    ),
    GetPage(
      name: Routes.THEME,
      page: () => ThemeSetPage(),
    ),
  ];
}
