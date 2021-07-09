import 'package:flutter_dingdian/moudules/read/model/content_model.dart';
import 'package:flutter_dingdian/network/net_constant.dart';
import 'package:flutter_dingdian/network/net_response.dart';
import 'package:flutter_dingdian/network/net_utils.dart';
import 'package:get/get.dart';

class BookReadApi {
  final String _chapterContent = "/BookFiles/Html";
  final NetUtils _utils = Get.find<NetUtils>();

  Future<BookChapterContentModel> getBookChapterContent(String url) async {
    NetBaseResponse response = await _utils.requestDataFuture(
        Method.get, _chapterContent + url,
        baseUrl: NetBaseApi.BASE_URL_MAP["content"]);
    if (response.success == true) {
      BookChapterContentModel model =
          BookChapterContentModel.fromJson(response.data);
      return model;
    } else {
      throw response.message ?? "请求出错了,请重试";
    }
  }
}
