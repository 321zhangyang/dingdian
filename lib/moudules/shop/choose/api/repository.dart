import 'package:flutter_dingdian/moudules/shop/choose/api/api.dart';
import 'package:flutter_dingdian/moudules/shop/choose/model/banner_model.dart';
import 'package:flutter_dingdian/moudules/shop/choose/model/choose_model.dart';
import 'package:get/get.dart';

class BookChooseRepository {
  final BookChooseApi api = Get.put(BookChooseApi());

  Future<List<BookBannerModel>> getBannerList() {
    return api.getBanner();
  }

  Future<List<BookChooseModel>> getChoose() {
    return api.getChoose();
  }
}
