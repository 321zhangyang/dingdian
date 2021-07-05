import 'package:flutter/material.dart';
import 'package:flutter_dingdian/moudules/common/model/tab_model.dart';
import 'package:flutter_dingdian/moudules/shop/choose/model/list_model.dart';
import 'package:flutter_dingdian/moudules/shop/top/api/repository.dart';
import 'package:fun_flutter_kit/fun_flutter_kit.dart';
import 'package:get/get.dart';

import 'state.dart';

class ShopTopLogic extends FunStateListRefresherController {
  final state = ShopTopState();
  final _repository = Get.put(BookChooseTopRepository());

  @override
  FunStateStatus initStatus() => FunStateStatus.idle();

  void initTabController(TickerProvider provider) {
    _initTabTitles();
    state.controller =
        TabController(vsync: provider, length: state.tabs.length);
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();

    refreshController.requestRefresh(duration: Duration(milliseconds: 200));
  }

  void changeTab(int index) {
    state.selectModel = state.tabs[index];
    //onLoadData(1);
    refreshController.requestRefresh(duration: Duration(milliseconds: 200));
  }

  void changeSubTab(int index) {
    state.selectSubModel = state.subTabs[index];
    for (var item in state.subTabs) {
      if (state.selectSubModel?.key == item.key) {
        item.isSelect = true;
      } else {
        item.isSelect = false;
      }
    }
    update();
    refreshController.requestRefresh(duration: Duration(milliseconds: 200));
  }

  _initTabTitles() {
    List<String> tabTitles = ["周榜", "月榜", "总榜"];
    List<String> tabKeys = ["week", "month", "total"];
    List<String> subTabTitles = ["最热榜", "完结榜", "收藏榜", "推荐榜", "新书榜", "评分榜"];
    List<String> subTabKeys = [
      "hot",
      "over",
      "collect",
      "commend",
      "new",
      "vote"
    ];
    state.tabs = [];
    state.subTabs = [];
    for (var i = 0; i < tabTitles.length; i++) {
      BookTabModel model = BookTabModel();
      model.key = tabKeys[i];
      model.name = tabTitles[i];
      state.tabs.add(model);
    }
    state.selectModel = state.tabs.first;
    for (var i = 0; i < subTabTitles.length; i++) {
      BookTabModel model = BookTabModel();
      model.key = subTabKeys[i];
      model.name = subTabTitles[i];
      state.subTabs.add(model);
    }
    state.selectSubModel = state.subTabs.first;
    state.selectSubModel!.isSelect = true;
  }

  @override
  Future<List> onLoadData(int pageNum, {int? pageSize}) async {
    String url =
        "/${state.selectSubModel?.key}/${state.selectModel?.key}/$pageNum.html";
    BookChooseListModel model = await _repository.getTopList(url);
    return model.bookList ?? [];
  }
}
