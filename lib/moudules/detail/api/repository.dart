import 'package:flutter_dingdian/moudules/detail/api/api.dart';
import 'package:flutter_dingdian/moudules/detail/model/info_model.dart';
import 'package:get/get.dart';

class BookDetailInfoRepository {
  final BookDetailInfoApi api = Get.put(BookDetailInfoApi());
  Future<BookDetailInfoModel> getChoose(String url) {
    return api.getChoose(url);
  }
}
