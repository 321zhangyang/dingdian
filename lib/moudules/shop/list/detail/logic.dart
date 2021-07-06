import 'package:flutter_dingdian/moudules/shop/list/api/repository.dart';
import 'package:flutter_dingdian/moudules/shop/list/model/detail_model.dart';
import 'package:flutter_dingdian/routes/app_routes.dart';
import 'package:fun_flutter_kit/fun_flutter_kit.dart';
import 'package:get/get.dart';

import 'state.dart';

class ShopBookListDetailLogic extends FunStateActionController {
  final state = ShopBookListDetailState();
  final _repository = Get.put(BookShopBookListRepository());

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    loadData();
  }

  jumpToDetail(String bookId) {
    Get.toNamed(Routes.DETAIL, arguments: {"bookId" : bookId});
  }

  @override
  Future onLoadData() async {
    String url = Get.arguments["bookId"] + ".html";
    ShopBookListDetailModel model = await _repository.getBookDetail(url);
    state.model = model;
  }
}
