import 'package:flutter_dingdian/moudules/shop/choose/model/banner_model.dart';
import 'package:flutter_dingdian/moudules/shop/choose/model/choose_model.dart';
import 'package:flutter_dingdian/network/net_response.dart';
import 'package:flutter_dingdian/network/net_utils.dart';
import 'package:get/get.dart';

class BookChooseApi {
  final String _banner = "/prov8/base/banner_man.html";
  final String _choose = "/prov8/base/man2.html";

  final NetUtils _utils = Get.find<NetUtils>();

  //获取精选页面轮播图
  Future<List<BookBannerModel>> getBanner() async {
    NetBaseResponse response =
        await _utils.requestDataFuture(Method.get, _banner);
    if (response.success == true) {
      List<BookBannerModel> datas = [];
      for (Map<String, dynamic> item in response.data) {
        print(item);
        BookBannerModel model = BookBannerModel.fromJson(item);
        datas.add(model);
      }
      return datas;
    } else {
      throw response.message ?? "出错了";
    }
  }

  //获取选择页面
  Future<List<BookChooseModel>> getChoose() async {
    NetBaseResponse response =
        await _utils.requestDataFuture(Method.get, _choose);
    if (response.success == true) {
      List<BookChooseModel> datas = [];
      for (Map<String, dynamic> item in response.data) {
        BookChooseModel model = BookChooseModel.fromJson(item);
        datas.add(model);
      }
      return datas;
    } else {
      throw response.message ?? "出错了";
    }
  }
}
