import 'package:flutter_dingdian/local/local_config_repository.dart';
import 'package:fun_flutter_kit/fun_flutter_kit.dart';
import 'package:get/get.dart';

import 'state.dart';

class MineBookListLogic extends FunStateActionController {
  final state = MineBookListState();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  @override
  Future onLoadData() async{
    state.list = await LocalBookConfigRepository.getBookReadHistroy();
    update();
  }
}
