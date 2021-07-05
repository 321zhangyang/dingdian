
import 'package:flutter_dingdian/moudules/shop/choose/model/list_model.dart';
import 'package:flutter_dingdian/moudules/shop/top/api/api.dart';
import 'package:get/get.dart';

class BookChooseTopRepository {
  final BookChooseTopApi api = Get.put(BookChooseTopApi());

    Future<BookChooseListModel> getTopList(String url) {
    return api.getTopList(url);
  }
}