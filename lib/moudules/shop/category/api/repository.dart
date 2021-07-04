import 'package:flutter_dingdian/moudules/shop/category/api/api.dart';
import 'package:flutter_dingdian/moudules/shop/choose/model/list_model.dart';
import 'package:get/get.dart';

class BookShopCategoryRepository {
  final BookShopCategoryApi api = Get.put(BookShopCategoryApi());

  Future<BookChooseListModel> getCategroyList(String url) {
    return api.getChooseList(url);
  }

}
