import 'package:flustars/flustars.dart';
import 'package:flutter_dingdian/moudules/detail/model/info_model.dart';

class BookDetailState {
  double alpha = 0;
  double appBarHeight = ScreenUtil.getInstance().appBarHeight +
      ScreenUtil.getInstance().statusBarHeight;
  BookDetailInfoModel? model;
  bool? showAllUser = false;
  bool isInShelf = false;
  BookDetailState() {
    ///Initialize variables
  }
}
