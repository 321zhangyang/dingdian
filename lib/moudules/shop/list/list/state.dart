import 'package:flutter/material.dart';
import 'package:flutter_dingdian/moudules/common/model/tab_model.dart';

class ShopBookListState {
  TabController? controller;
  List<BookTabModel> tabs = [];
  BookTabModel? selectModel;
  ShopBookListState() {
    ///Initialize variables
  }
}
