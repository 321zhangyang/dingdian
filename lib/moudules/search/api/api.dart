import 'package:flutter_dingdian/moudules/search/model/result.dart';
import 'package:flutter_dingdian/network/net_constant.dart';
import 'package:flutter_dingdian/network/net_response.dart';
import 'package:flutter_dingdian/network/net_utils.dart';
import 'package:get/get.dart';

class BookSearchApi {
  final NetUtils _utils = Get.find<NetUtils>();

  Future<List<BookSearchResultModel>> getSearchResult(Map<String ,dynamic> params) async {
    NetBaseResponse response = await _utils.requestDataFuture(Method.get, "",
        baseUrl: NetBaseApi.BASE_URL_MAP["search"],queryParameters: params);
    if (response.success == true) {
      List<BookSearchResultModel> datas = [];
      for (Map<String, dynamic> item in response.data) {
        BookSearchResultModel model = BookSearchResultModel.fromJson(item);
        datas.add(model);
      }
      return datas;
    } else {
      throw response.message ?? "出错了";
    }
  }
}
