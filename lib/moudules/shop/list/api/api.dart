import 'package:flutter_dingdian/moudules/shop/list/model/detail_model.dart';
import 'package:flutter_dingdian/moudules/shop/list/model/list_model.dart';
import 'package:flutter_dingdian/network/net_response.dart';
import 'package:flutter_dingdian/network/net_utils.dart';
import 'package:get/get.dart';

class BookShopBookListApi {
  final String _list = "/shudan/man/all";
  final String _detail = "/shudan/detail/";
  final NetUtils _utils = Get.find<NetUtils>();

  Future<List<ShopBookListModel>> getBookList(String url) async {
    NetBaseResponse response =
        await _utils.requestDataFuture(Method.get, _list + url);
    if (response.success == true) {
      List<ShopBookListModel> datas = [];
      for (Map<String, dynamic> item in response.data) {
        ShopBookListModel model = ShopBookListModel.fromJson(item);
        datas.add(model);
      }
      return datas;
    } else {
      throw response.message ?? "出错了";
    }
  }

  Future<ShopBookListDetailModel> getBookListDetail(String url) async {
     NetBaseResponse response =
        await _utils.requestDataFuture(Method.get, _detail + url);
    if (response.success == true) {
      ShopBookListDetailModel model = ShopBookListDetailModel.fromJson(response.data);
      return model;
    } else {
      throw response.message ?? "出错了";
    }
  }
}
