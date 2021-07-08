import 'package:flutter_dingdian/moudules/detail/direcory/view.dart';
import 'package:flutter_dingdian/moudules/mine/history/view.dart';
import 'package:flutter_dingdian/moudules/mine/theme/theme_view.dart';
import 'package:flutter_dingdian/moudules/search/view.dart';
import 'package:flutter_dingdian/moudules/shop/category/list/view.dart';
import 'package:flutter_dingdian/moudules/shop/choose/list/view.dart';
import 'package:flutter_dingdian/moudules/shop/choose/more/view.dart';
import 'package:flutter_dingdian/moudules/detail/detail/view.dart';
import 'package:flutter_dingdian/moudules/shop/list/detail/view.dart';
import 'package:flutter_dingdian/moudules/tabbar/tabbar_page.dart';
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
      page: () => ThemePage(),
    ),
    GetPage(
      name: Routes.CHOOSELIST,
      page: () => BookChooseListPage(),
    ),
    GetPage(
      name: Routes.CHOOSEMORE,
      page: () => ShopChooseMorePage(),
    ),
    GetPage(
      name: Routes.DETAIL,
      page: () => BookDetailPage(),
    ),
    GetPage(
      name: Routes.DETAILDIRECTORY,
      page: () => BookDetailDirectoryPage(),
    ),
    GetPage(name: Routes.CATEGORYLIST, page: () => ShopCategoryListPage()),
    GetPage(
      name: Routes.LISTDETAIL,
      page: () => ShopBookListDetailPage(),
    ),
    GetPage(
      name: Routes.SEARCH,
      page: () => BookSearchPage(),
    ),
    
    GetPage(
      name: Routes.READHISTORY,
      page: () => MineReadHistoryPage(),
    ),

  ];
}
