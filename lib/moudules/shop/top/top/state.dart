import 'package:flutter/material.dart';
import 'package:flutter_dingdian/moudules/common/model/tab_model.dart';

class ShopTopState {
  TabController? controller;

  List<BookTabModel> tabs = [];
  List<BookTabModel> subTabs = [];
  BookTabModel? selectModel = BookTabModel(
    
  );
  BookTabModel? selectSubModel;
  String type = "hot";
  String subType = "new";
  ShopTopState() {
    ///Initialize variables
  }
}
