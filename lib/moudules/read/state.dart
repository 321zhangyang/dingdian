import 'package:flutter/material.dart';
import 'package:flutter_dingdian/moudules/detail/model/directory_model.dart';
import 'package:flutter_dingdian/moudules/read/model/content_model.dart';

class BookReadState {
  // 图书所有章节
  BookDirectoryModel? chapterModel;
  List<TwoList> allChapters = [];
  // 当前章节内容
  BookChapterContentModel? cContentModel;
  // 下一章节内容
  BookChapterContentModel? nContentModel;
  // 前一章节内容
  BookChapterContentModel? pContentModel;
  //标题的style
  TextStyle titleStyle = TextStyle();
  // 正文的style
  TextStyle contentStyle = TextStyle();
  // 
  PageController pageController = PageController(keepPage: false);
  BookReadState();
}
