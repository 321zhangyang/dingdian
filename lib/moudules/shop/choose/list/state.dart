import 'package:flutter/material.dart';

class ShopChooseListState {
  List<String> tabTitles = ["周榜", "月榜", "总榜"];
  String type = "week";
  TabController? controller;
  ShopChooseListState() {
    ///Initialize variables
  }
}
