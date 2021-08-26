import 'package:fijkplayer/fijkplayer.dart';
import 'package:fun_flutter_kit/fun_flutter_kit.dart';
import 'package:get/get.dart';

import 'state.dart';

class LivePlayLogic extends FunStateActionController {
  final state = LivePlayState();
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    print(Get.arguments["address"]);
    state.player.setDataSource(Get.arguments["address"], autoPlay: true);
    update();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();

    state.player.release();
  }

  @override
  Future onLoadData() {
    // TODO: implement onLoadData
    throw UnimplementedError();
  }

}
