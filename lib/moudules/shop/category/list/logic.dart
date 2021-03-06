import 'package:flutter/material.dart';
import 'package:flutter_dingdian/moudules/shop/category/api/repository.dart';
import 'package:flutter_dingdian/moudules/shop/category/model/category_model.dart';
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
      case 0:
        state.type = "hot";
        break;
      case 1:
        state.type = "new";
        break;
      case 2:
        state.type = "vote";
        break;
      case 3:
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
    if (state.model == null) {
      state.model = Get.arguments["model"];
    }
    BookCategoryModel categoryModel = state.model!;
    String url = "/${categoryModel.id}/${state.type}/$pageNum.html";
    BookChooseListModel model = await _repository.getCategroyList(url);
    return model.bookList ?? [];
  }

  @override
  void onInit() {
    super.onInit();
  }
}
