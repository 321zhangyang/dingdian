import 'package:flutter_dingdian/local/local_config_repository.dart';
import 'package:fun_flutter_kit/fun_flutter_kit.dart';

import 'state.dart';

class BookSearchLogic extends FunStateListRefresherController {
  final state = BookSearchState();

  @override
  FunStateStatus initStatus() => FunStateStatus.idle();
  @override
  void onInit() async {
    super.onInit();

    state.historys = await LocalBookConfigRepository.getHistory();
    print(state.historys);
    update();
  }

  @override
  Future<List> onLoadData(int pageNum, {int? pageSize}) async {
    return ["1", "2", "3"];
  }

  saveHistory(String value) {
     LocalBookConfigRepository.saveHistory(value);
  }

  cleanHistory() {
    LocalBookConfigRepository.clearHistory();
    update();
  }
}
