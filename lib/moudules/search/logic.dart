import 'package:flutter_dingdian/local/local_search_history_repository.dart';
import 'package:fun_flutter_kit/fun_flutter_kit.dart';
import 'package:get/get.dart';

import 'state.dart';

class BookSearchLogic extends FunStateListRefresherController {
  final state = BookSearchState();

  @override
  FunStateStatus initStatus() => FunStateStatus.idle();
  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();

    state.historys = await SearchHistoryRepository.getHistory();
    print(state.historys);
    update();
  }

  @override
  Future<List> onLoadData(int pageNum, {int? pageSize}) async {
    return ["1", "2", "3"];
  }

  cleanHistory() {
    SearchHistoryRepository.clearHistory();
    update();
  }
}
