import 'package:flutter/material.dart';
import 'package:flutter_dingdian/moudules/common/model/tab_model.dart';
import 'package:flutter_dingdian/moudules/shop/list/api/repository.dart';
import 'package:flutter_dingdian/routes/app_routes.dart';
import 'package:fun_flutter_kit/state/src/controller/fun_state_list_refresher_controller.dart';
import 'package:fun_flutter_kit/state/src/controller/fun_state_mixin.dart';
import 'package:get/get.dart';

import 'state.dart';

class ShopBookListLogic extends FunStateListRefresherController {
  final state = ShopBookListState();
  final _repository = Get.put(BookShopBookListRepository());

  @override
  FunStateStatus initStatus() => FunStateStatus.idle();

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();

    refreshController.requestRefresh(duration: Duration(milliseconds: 200));
  }

  void initTabController(TickerProvider provider) {
    _initTabTitles();
    state.controller =
        TabController(vsync: provider, length: state.tabs.length);
  }

  void changeTab(int index) {
    state.selectModel = state.tabs[index];
    refreshController.requestRefresh(duration: Duration(milliseconds: 200));
  }

  void jumpToDetail(String bookId) {
    Get.toNamed(Routes.LISTDETAIL, arguments: {
      "bookId" : bookId
    });
  }

  _initTabTitles() {
    List<String> tabTitles = ["最新发布", "本周最热", "最多收藏", "小编推荐"];
    List<String> tabKeys = ["new", "hot", "collect", "commend"];
    state.tabs = [];
    for (var i = 0; i < tabTitles.length; i++) {
      BookTabModel model = BookTabModel();
      model.key = tabKeys[i];
      model.name = tabTitles[i];
      state.tabs.add(model);
    }
    state.selectModel = state.tabs.first;
  }

  @override
  Future<List> onLoadData(int pageNum, {int? pageSize}) {
    String url = "/${state.selectModel?.key}/$pageNum.html";
    return _repository.getBookList(url);
  }
}
