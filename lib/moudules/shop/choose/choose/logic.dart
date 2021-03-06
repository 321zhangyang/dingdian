import 'package:flutter_dingdian/moudules/shop/choose/api/repository.dart';
import 'package:flutter_dingdian/moudules/shop/choose/model/banner_model.dart';
import 'package:flutter_dingdian/moudules/shop/choose/model/choose_model.dart';
import 'package:flutter_dingdian/routes/app_routes.dart';
import 'package:fun_flutter_kit/state/src/controller/fun_state_action_controller.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'state.dart';

class ShopChooseLogic extends FunStateActionController {
  final state = ShopChooseState();
  final _repository = Get.put(BookChooseRepository());

  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  @override
  void onInit() {
    super.onInit();

    getdata();
  }

  @override
  Future onLoadData() async {
    return getdata();
  }

  getdata() async{
    changeLoading();
    Future.wait([
      _repository.getBannerList(),
      _repository.getChoose(),
    ]).then((value) {
      state.banner = value.first.cast<BookBannerModel>();
      state.choose = value.last.cast<BookChooseModel>();
      changeIdle();
    }).catchError((e) {
      changeError(e);
    });
  }

  jumpToList(int index, String title) {
    Get.toNamed(Routes.CHOOSELIST,
        arguments: {"key": state.menuKeys![index], "title": title});
  }

  jumpToMore(String title, String url) {
    Get.toNamed(Routes.CHOOSEMORE, arguments: {"title": title, "url": url});
  }
  
  jumpToDetail(String bookId) {
      Get.toNamed(Routes.DETAIL, arguments: {"bookId": bookId});
    }
}
