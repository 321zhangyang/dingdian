import 'package:flutter_dingdian/local/local_config_repository.dart';
import 'package:flutter_dingdian/routes/app_routes.dart';
import 'package:fun_flutter_kit/state/src/controller/fun_state_action_controller.dart';
import 'package:get/get.dart';

import 'state.dart';

class MineReadHistoryLogic extends FunStateActionController {
  final state = MineReadHistoryState();

  @override
  Future onLoadData() async {
    state.list = await LocalBookConfigRepository.getBookReadHistroy();
    update();
  }

  cleanReadHistory() async {
    await LocalBookConfigRepository.deleteBookReadHistory();
    state.list = [];
    update();
  }

  jumpToDetail(String bookId) {
    Get.toNamed(Routes.DETAIL,arguments: {
      "bookId": bookId
    });
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    loadData();
  }
}
