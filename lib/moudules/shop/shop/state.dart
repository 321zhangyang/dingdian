import 'package:flutter/material.dart';

class ShopState {
  List<String> titles = ["小说", "漫画"];
  List<String> tabs = ["精选", "分类", "榜单", "书单"];
  TabController? controller;
  PageController? pageController;
  ShopState() {
    ///Initialize variables
  }
}
