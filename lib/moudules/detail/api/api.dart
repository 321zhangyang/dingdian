
import 'package:flutter_dingdian/moudules/detail/model/directory_model.dart';
import 'package:flutter_dingdian/moudules/detail/model/info_model.dart';
import 'package:flutter_dingdian/network/net_constant.dart';
import 'package:flutter_dingdian/network/net_response.dart';
import 'package:flutter_dingdian/network/net_utils.dart';
import 'package:get/get.dart';

class BookDetailInfoApi {
  final String _info = "/BookFiles/Html/";
  final NetUtils _utils = Get.find<NetUtils>();

  //获取选择页面
  Future<BookDetailInfoModel> getChoose(String url) async {
    NetBaseResponse response =
        await _utils.requestDataFuture(Method.get, _info + url,baseUrl: NetBaseApi.BASE_URL_MAP["info"]);
    if (response.success == true) {
      BookDetailInfoModel model = BookDetailInfoModel.fromJson(response.data);
      return model;
    } else {
      throw response.message ?? "出错了";
    }
  }
  
  Future<BookDirectoryModel> getDirectory(String url) async {
     NetBaseResponse response = await _utils.requestDataFuture(
        Method.get, _info + url,
        baseUrl: NetBaseApi.BASE_URL_MAP["info"]);
    if (response.success == true) {
      BookDirectoryModel model = BookDirectoryModel.fromJson(response.data);
      return model;
    } else {
      throw response.message ?? "出错了";
    }
  }

}
