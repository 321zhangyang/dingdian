import 'package:flutter/material.dart';
import 'package:flutter_dingdian/moudules/shop/choose/api/repository.dart';
import 'package:flutter_dingdian/moudules/shop/choose/model/list_model.dart';
import 'package:fun_flutter_kit/state/src/controller/fun_state_list_refresher_controller.dart';
import 'package:get/get.dart';
import 'state.dart';

class ShopChooseListLogic extends FunStateListRefresherController {
  final state = ShopChooseListState();
  final _repository = Get.find<BookChooseRepository>();


  void initTabController(TickerProvider provider) {
    state.controller =
        TabController(vsync: provider, length: state.tabTitles.length);
  }

  void changeTab(int index) {
    state.type = index == 0
        ? "week"
        : index == 1
            ? "month"
            : "total";
    //load

    pullToRefresh(isInit: true);
  }

  @override
  Future<List<BookList>> onLoadData(int pageNum, {int? pageSize}) async {
    print(pageNum);
    String url = "/${Get.arguments["key"]}/${state.type}/$pageNum.html";
    BookChooseListModel model = await _repository.getChooseList(url);

    return model.bookList ?? [];
  }
}
