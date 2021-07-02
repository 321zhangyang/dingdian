import 'package:flutter_dingdian/moudules/shop/choose/model/banner_model.dart';
import 'package:flutter_dingdian/moudules/shop/choose/model/choose_model.dart';

class ShopChooseState {
  List<BookBannerModel>? banner = [];
  List<BookChooseModel>? choose = [];
  List<String>? menuKeys = [
    "commend",
    "collect",
    "vote",
    "over",
    "hot"
  ];
  ShopChooseState() {
    ///Initialize variables
  }
}
