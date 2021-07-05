

import 'package:flutter_dingdian/moudules/shop/list/api/api.dart';
import 'package:flutter_dingdian/moudules/shop/list/model/list_model.dart';
import 'package:get/get.dart';

class BookShopBookListRepository {
  final BookShopBookListApi api = Get.put(BookShopBookListApi());

  Future<List<ShopBookListModel>> getBookList(String url) {
    return api.getBookList(url);
  }
}
