import 'package:flutter/material.dart';
import 'package:flutter_dingdian/moudules/detail/api/repository.dart';
import 'package:flutter_dingdian/moudules/detail/model/info_model.dart';
import 'package:flutter_dingdian/routes/app_routes.dart';
import 'package:fun_flutter_kit/state/src/controller/fun_state_action_controller.dart';
import 'package:get/get.dart';

import 'state.dart';

class BookDetailLogic extends FunStateActionController {
  final state = BookDetailState();
  final _repository = Get.put(BookDetailInfoRepository());

  onScroll(offset) {
    double alpha = offset / state.appBarHeight;
    if (alpha < 0) {
      alpha = 0;
    } else if (alpha > 1) {
      alpha = 1;
    }
    state.alpha = alpha;
    update();
  }

  @override
  void onInit() {
    super.onInit();

    loadData();
  }

  showSameUser() {
    state.showAllUser = !state.showAllUser!;
    update();
  }

  int getSameUsersLength() {
    if (state.model!.sameUserBooks!.length > 3) {
      if (state.showAllUser == true) {
        return state.model!.sameUserBooks!.length;
      } else {
        return 3;
      }
    } else {
      return state.model!.sameUserBooks!.length;
    }
  }

  @override
  Future onLoadData() async {
    //拼接地址 id删除后三位 将剩余的id + 1,然后再拼接
    String bookId = Get.arguments["bookId"];
    int index = int.parse(bookId.substring(0, bookId.length - 3)) + 1;
    String url = "$index/$bookId/info.html";
    BookDetailInfoModel model = await _repository.getChoose(url);
    state.model = model;
    if (model.sameUserBooks != null) {
      state.showAllUser = model.sameUserBooks!.length > 3 ? false : true;
    }
    return model;
  }

  jumpToDirectory() {
    Get.toNamed(Routes.DETAILDIRECTORY, arguments: {
      "title": state.model?.name,
      "bookId": state.model?.id
    });
  }
}
