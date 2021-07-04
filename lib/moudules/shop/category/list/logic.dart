import 'package:flutter/material.dart';
import 'package:flutter_dingdian/moudules/shop/category/api/api.dart';
import 'package:flutter_dingdian/moudules/shop/category/api/repository.dart';
import 'package:flutter_dingdian/moudules/shop/category/model/category_model.dart';
import 'package:flutter_dingdian/moudules/shop/choose/api/repository.dart';
import 'package:flutter_dingdian/moudules/shop/choose/model/list_model.dart';
import 'package:flutter_dingdian/routes/app_routes.dart';
import 'package:fun_flutter_kit/state/src/controller/fun_state_list_refresher_controller.dart';
import 'package:get/get.dart';

import 'state.dart';

class ShopCategoryListLogic extends FunStateListRefresherController {
  final state = ShopCategoryListState();

  final _repository = Get.put(BookShopCategoryRepository());

  void initTabController(TickerProvider provider) {
    state.controller =
        TabController(vsync: provider, length: state.tabTitles.length);
  }

  void changeTab(int index) {
    switch (index) {
      case 1:
        state.type = "hot";
        break;
      case 2:
        state.type = "new";
        break;
      case 3:
        state.type = "vote";
        break;
      case 4:
        state.type = "over";
        break;
      default:
    }
    //load

    pullToRefresh(isInit: true);
  }

  jumpToDetail(String bookId) {
    Get.toNamed(Routes.DETAIL, arguments: {"bookId": bookId});
  }

  @override
  Future<List<BookList>> onLoadData(int pageNum, {int? pageSize}) async {
    BookCategoryModel categoryModel = Get.arguments["model"];
    String url = "/${categoryModel.id}/${state.type}/$pageNum.html";
    BookChooseListModel model = await _repository.getCategroyList(url);
    state.title = categoryModel.name ?? "";
    return model.bookList ?? [];
  }
}
