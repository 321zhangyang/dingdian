import 'package:flutter_dingdian/moudules/shop/choose/api/repository.dart';
import 'package:flutter_dingdian/moudules/shop/choose/model/list_model.dart';
import 'package:fun_flutter_kit/state/src/controller/fun_state_list_refresher_controller.dart';
import 'package:get/get.dart';

import 'state.dart';

class ShopChooseMoreLogic extends FunStateListRefresherController {
  final state = ShopChooseMoreState();
  final _repository = Get.find<BookChooseRepository>();

  @override
  Future<List<BookList>> onLoadData(int pageNum, {int? pageSize}) async {
    String url = Get.arguments["url"];
   url = url.replaceAll("{page}", pageNum.toString());
    BookChooseListModel model = await _repository.getChooseMore(url);
    return model.bookList ?? [];
  }
}
