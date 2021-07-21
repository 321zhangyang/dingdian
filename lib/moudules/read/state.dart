import 'package:flutter/material.dart';
import 'package:flutter_dingdian/moudules/detail/model/directory_model.dart';
import 'package:flutter_dingdian/moudules/detail/model/info_model.dart';
import 'package:flutter_dingdian/moudules/read/model/config_model.dart';
import 'package:flutter_dingdian/moudules/read/model/content_model.dart';
import 'package:list_group_handler/list_group_handler.dart';

class BookReadState {
  //图书详情
  BookDetailInfoModel? bookModel;
  // 图书所有章节
  BookDirectoryModel? chapterModel;
  List<TwoList> allChapters = [];
  //存放目录页用的
  List<TwoList> dirChapters = [];
  // 当前章节内容
  BookChapterContentModel? cContentModel;
  // 下一章节内容
  BookChapterContentModel? nContentModel;
  // 前一章节内容
  BookChapterContentModel? pContentModel;
  //配置model
  BookReadConfigModel? configModel;
  //标题的style
  TextStyle titleStyle = TextStyle();
  // 正文的style
  TextStyle contentStyle = TextStyle();
  //
  PageController pageController = PageController(keepPage: false);

  ListViewGroupHandler? groupHandler;
  //目录排序
  bool positive = true;
  //全局key
  final readKey = new GlobalKey<NavigatorState>();
  //是否展示菜单
  bool offstage = true;
  //最后一个展示的page,此处放在page,是方便切换目录后,置空
  Widget? lastPage;
  BookReadState();
}
