import 'package:fun_flutter_kit/fun_flutter_kit.dart';
import 'package:get/get.dart';

import 'state.dart';

class MineLogic extends FunStateActionController {
  final state = MineState();

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();

  }

  @override
  Future onLoadData() {
    // TODO: implement onLoadData
    throw UnimplementedError();
  }
}
