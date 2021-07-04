import 'package:flutter_dingdian/moudules/shop/choose/model/list_model.dart';
import 'package:flutter_dingdian/network/net_response.dart';
import 'package:flutter_dingdian/network/net_utils.dart';
import 'package:get/get.dart';

class BookShopCategoryApi {
  final String _list = "/Categories";

  final NetUtils _utils = Get.find<NetUtils>();

  Future<BookChooseListModel> getChooseList(String url) async {
    NetBaseResponse response =
        await _utils.requestDataFuture(Method.get, _list + url);
    if (response.success == true) {
      BookChooseListModel model = BookChooseListModel.fromJson(response.data);
      return model;
    } else {
      throw response.message ?? "出错了";
    }
  }
}
