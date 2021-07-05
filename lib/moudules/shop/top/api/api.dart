import 'package:flutter_dingdian/moudules/shop/choose/model/list_model.dart';
import 'package:flutter_dingdian/network/net_response.dart';
import 'package:flutter_dingdian/network/net_utils.dart';
import 'package:get/get.dart';

class BookChooseTopApi {
  final String _list = "/top/man/top";

  final NetUtils _utils = Get.find<NetUtils>();

   Future<BookChooseListModel> getTopList(String url) async {
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
