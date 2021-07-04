import 'package:flutter/material.dart';

class ShopCategoryListState {
  List<String> tabTitles = ["热门", "新书", "好评", "完结"];
  String type = "hot";
  TabController? controller;
  String title = "";
  ShopCategoryListState() {
    ///Initialize variables
  }
}
