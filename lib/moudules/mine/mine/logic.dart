import 'package:fun_flutter_kit/fun_flutter_kit.dart';

import 'state.dart';

class MineLogic extends FunStateActionController {
  final state = MineState();

  @override
  void onReady() {
    super.onReady();

  }

  @override
  Future onLoadData() {
    throw UnimplementedError();
  }
}
