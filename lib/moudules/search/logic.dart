import 'package:flutter_dingdian/local/local_config_repository.dart';
import 'package:flutter_dingdian/moudules/detail/api/repository.dart';
import 'package:flutter_dingdian/moudules/search/api/repository.dart';
import 'package:fun_flutter_kit/fun_flutter_kit.dart';
import 'package:get/get.dart';

import 'state.dart';

class BookSearchLogic extends FunStateListRefresherController {
  final state = BookSearchState();
  final _repository = Get.put(BookSearchRepository());

  @override
  FunStateStatus initStatus() => FunStateStatus.idle();
  @override
  void onInit() async {
    super.onInit();

    state.historys = await LocalBookConfigRepository.getSearchHistory();
    update();
  }

  @override
  Future<List> onLoadData(int pageNum, {int? pageSize}) async {
    Map<String, dynamic> params = {
      "key": state.searchKey ?? "",
      "page": pageNum,
      "siteid": "app2"
    };
    state.isSearch = true;
    return await _repository.getSearchResult(params);
  }

  search(String value) {
    state.controller.text = value;
    state.searchKey = value;
    saveHistory(value);
    pullToRefresh();
  }

  reset() {
    state.isSearch = false;
    update();
  }

  saveHistory(String value) {
    LocalBookConfigRepository.saveSearchHistory(value);
  }

  cleanHistory() {
    state.isSearch = false;
    LocalBookConfigRepository.clearSearchHistory();
    state.historys = [];
    update();
  }
}
