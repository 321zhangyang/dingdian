import 'package:flutter/material.dart';
import 'package:flutter_dingdian/moudules/shop/category/model/category_model.dart';

class ShopCategoryListState {
  List<String> tabTitles = ["热门", "新书", "好评", "完结"];
  String type = "hot";
  TabController? controller;
  String title = "";
  BookCategoryModel? model;
  ShopCategoryListState() {
    ///Initialize variables
  }
}
