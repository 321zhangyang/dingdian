import 'package:flutter/material.dart';
import 'package:flutter_dingdian/moudules/mine/mine/view.dart';
import 'package:flutter_dingdian/moudules/shelf/view.dart';
import 'package:flutter_dingdian/moudules/shop/shop/view.dart';



List<Widget> pageList = [BookShelfPage(),ShopPage(),MinePage()];
final List<String> appBarTitles = ['书架', '书城','我的'];


List normalImgUrls = [
  "assets/images/KKStriveImg_tabbar_shelfNor_Normal.png",
  "assets/images/KKStriveImg_tabbar_shopNor_Normal.png",
  "assets/images/KKStriveImg_tabbar_userNor_Normal.png",
];
List selectedImgUrls = [
  "assets/images/KKStriveImg_tabbar_shelfSel_Normal.png",
  "assets/images/KKStriveImg_tabbar_shopSel_Normal.png",
  "assets/images/KKStriveImg_tabbar_userSel_Normal.png",
];


