import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dingdian/constant/colors.dart';
import 'package:flutter_dingdian/local/local_config_repository.dart';
import 'package:flutter_dingdian/moudules/detail/api/repository.dart';
import 'package:flutter_dingdian/moudules/detail/direcory/widgets/header.dart';
import 'package:flutter_dingdian/moudules/detail/direcory/widgets/item.dart';
import 'package:flutter_dingdian/moudules/detail/model/directory_model.dart';
import 'package:flutter_dingdian/moudules/read/api/repository.dart';
import 'package:flutter_dingdian/moudules/read/model/config_model.dart';
import 'package:flutter_dingdian/moudules/read/model/content_model.dart';
import 'package:flutter_dingdian/utils/text/text_composition.dart';
import 'package:fun_flutter_kit/fun_flutter_kit.dart';
import 'package:get/get.dart';
import 'package:list_group_handler/list_group_handler.dart';

import 'state.dart';

class BookReadLogic extends FunStateActionController {
  final state = BookReadState();
  final _chapterRepository = Get.put(BookDetailInfoRepository());
  final _contentRepository = Get.put(BookReadRepository());

  //获取所有章节
  getBookChapters() async {
    //拼接地址 id删除后三位 将剩余的id + 1,然后再拼接
    String bookId = Get.arguments["bookId"].toString();
    int index = int.parse(bookId.substring(0, bookId.length - 3)) + 1;
    String url = "$index/$bookId/index.html";
    BookDirectoryModel model = await _chapterRepository.getBookDirectory(url);
    state.chapterModel = model;
    //将所有可阅读的章节,分离出来,方便取用,以及跳转
    for (OneList one in state.chapterModel!.list!) {
      for (TwoList two in one.list!) {
        state.allChapters.add(two);
      }
    }
    resetContent(0);
  }

  //重置内容
  resetContent(int index) async {
    state.cContentModel =
        await getBookChapterContent(state.allChapters[index].id.toString());
    state.cContentModel!.index = index;
    if (state.cContentModel!.pid! > 0) {
      state.pContentModel =
          await getBookChapterContent(state.cContentModel!.pid.toString());
      state.pContentModel!.index = index - 1;
    } else {
      state.pContentModel = null;
    }
    if (state.cContentModel!.nid! > 0) {
      state.nContentModel =
          await getBookChapterContent(state.cContentModel!.nid.toString());
      state.nContentModel!.index = index - 1;
    } else {
      state.nContentModel = null;
    }
    if (state.pContentModel != null) {
      state.pageController.jumpToPage(state.pContentModel!.pages!.length);
    }
    update();
    _initGroupHandler();
  }

  //获取章节内容
  Future<BookChapterContentModel> getBookChapterContent(
      String chapterId) async {
    //拼接地址 id删除后三位 将剩余的id + 1,然后再拼接
    String bookId = Get.arguments["bookId"].toString();
    int path = int.parse(bookId.substring(0, bookId.length - 3)) + 1;
    String url = "/$path/$bookId/$chapterId.html";
    BookChapterContentModel model =
        await _contentRepository.getBookChapterContent(url);

    //犹豫返回的章节头部和尾部带有多余字符,这里除去头部和尾部多余的字符,否则会影响排版
    model.content = model.content?.substring(2);
    model.content = model.content?.replaceAll("\f\t\n", "");
    model.pages = parseContent(model.content ?? "", model.cname ?? "");
    return model;
  }

  //对章节内容机型解析
  List<TextPage> parseContent(String content, String title,
      {shouldJustifyHeight = true, justRender = false}) {
    TextComposition textComposition = TextComposition(
        text: content,
        style: state.contentStyle,
        titleStyle: state.titleStyle,
        paragraph: 20 * 1.7 * 0.1,
        title: title,
        padding: EdgeInsets.all(20),
        shouldJustifyHeight: shouldJustifyHeight,
        debug: false,
        justRender: justRender,
        boxSize: Size(
            ScreenUtil.getInstance().screenWidth,
            ScreenUtil.getInstance().screenHeight -
                50 -
                ScreenUtil.getInstance().bottomBarHeight));
    return textComposition.pages;
  }

  //滚动判断
  onScroll() async {
    var page =
        state.pageController.offset / ScreenUtil.getInstance().screenWidth;
    int nextArtilePage = state.cContentModel!.pages!.length +
        (state.pContentModel != null ? state.pContentModel!.pages!.length : 0);
    if (page >= nextArtilePage) {
      print("到达下一个章节");
      state.pContentModel = state.cContentModel;
      state.cContentModel = state.nContentModel;
      state.pageController.jumpToPage(state.pContentModel!.pages!.length);
      if (state.cContentModel!.nid! > 0) {
        state.nContentModel =
            await getBookChapterContent(state.cContentModel!.nid.toString());
        state.nContentModel!.index = state.cContentModel!.index! + 1;
      } else {
        state.nContentModel = null;
      }
      update();
    }

    if (state.pContentModel != null &&
        page <= state.pContentModel!.pages!.length - 1) {
      print("到达上一个章节");
      state.nContentModel = state.cContentModel;
      state.cContentModel = state.pContentModel;
      state.pContentModel = null;
      state.pageController.jumpToPage(state.cContentModel!.pages!.length - 1);
      if (state.cContentModel!.pid! > 0) {
        state.pContentModel =
            await getBookChapterContent(state.cContentModel!.pid.toString());
        state.pageController.jumpToPage(state.cContentModel!.pages!.length -
            1 +
            state.pContentModel!.pages!.length);
        state.pContentModel!.index = state.pContentModel!.index! - 1;
      } else {
        state.pContentModel = null;
      }
    }
  }

  // -------- 菜单操作 ---------

  //展示隐藏菜单
  showMenu() {
    state.offstage = !state.offstage;
    update();
  }

  //展示目录
  showDirectory(BuildContext context) {
    Scaffold.of(context).openDrawer();
  }

  //对目录进行排序
  sortTheDirectory() {
    state.positive = !state.positive;
    state.chapterModel?.list = state.chapterModel!.list!.reversed.toList();
    for (var item in state.chapterModel!.list!) {
      item.list = item.list!.reversed.toList();
    }
    update();
  }

  //切换字体大小
  changeFont(bool reduce) {
    if (reduce) {
      state.configModel!.font =
          state.configModel!.font! - 1 < 15 ? 15 : state.configModel!.font! - 1;
    } else {
      state.configModel!.font =
          state.configModel!.font! + 1 > 30 ? 30 : state.configModel!.font! + 1;
    }
    state.configModel!.save();
    changeTextContent();
  }

  changeHeight(bool reduce) {
    if (reduce) {
      state.configModel!.height = state.configModel!.height! - 0.1 < 1
          ? 1
          : state.configModel!.height! - 0.1;
    } else {
      state.configModel!.height = state.configModel!.height! + 0.1 > 5
          ? 5
          : state.configModel!.height! + 0.1;
    }
    state.configModel!.save();
    changeTextContent();
  }

  //更改完成设置后,重新处理文字内容
  changeTextContent() {
    state.contentStyle = TextStyle(
        fontSize: state.configModel!.font!.toDouble(),
        color: MyColors.text_color,
        height: state.configModel!.height);
    print("state.configModel!.height ${state.configModel!.height}");
    state.cContentModel!.pages = parseContent(
        state.cContentModel!.content!, state.cContentModel!.cname!);
    if (state.pContentModel != null) {
      state.pContentModel!.pages = parseContent(
          state.pContentModel!.content!, state.pContentModel!.cname!);
    }
    if (state.nContentModel != null) {
      state.nContentModel!.pages = parseContent(
          state.nContentModel!.content!, state.nContentModel!.cname!);
    }
    update();
  }
   
  //切换主题
  changeTheme(String theme) async {
    state.configModel!.theme = theme;
    state.configModel!.save();
    update();
  }

  @override
  void onInit() async {
    super.onInit();
    state.pageController.addListener(onScroll);

    var configModel = await LocalBookConfigRepository.getBookReadConfigModel();
    if (configModel == null) {
      BookReadConfigModel model = BookReadConfigModel();
      model.font = 20;
      model.height = 1.5;
      model.index = 0;
      model.theme = "theme2_read_bg";
      LocalBookConfigRepository.saveBookReadConfig(model);
      state.configModel = model;
    } else {
      print("有了配置信息");
      state.configModel = configModel;
    }
    state.titleStyle = TextStyle(
        fontSize: 30, color: MyColors.text_color, fontWeight: FontWeight.bold);
    state.contentStyle = TextStyle(
        fontSize: state.configModel!.font!.toDouble(),
        color: MyColors.text_color,
        height: state.configModel!.height);
    getBookChapters();
  }

  @override
  Future onLoadData() {
    return getBookChapters();
  }

  //初始化章节内容的Handler
  _initGroupHandler() {
    state.groupHandler = ListViewGroupHandler(
      //日志开关
      openLog: false,
      //分组数量，需要自行根据data设置，默认1
      numberOfSections: state.chapterModel!.list!.length,
      //每组cell个数，需要自行根据data设置
      numberOfRowsInSection: (section) =>
          state.chapterModel!.list![section].list!.length,
      //indexPath: IndexPath(section,row,index)
      cellForRowAtIndexPath: (indexPath) => GestureDetector(
        onTap: () {
          print("点击目录选择");
          resetContent(indexPath.row);
          Navigator.pop(state.readKey.currentContext!);
        },
        child: BookDirectoryItemWidget(
            item: state
                .chapterModel!.list![indexPath.section].list![indexPath.row],
            select: indexPath.row == state.cContentModel!.index),
      ),
      //头部
      headerForSection: (section) => BookDirectoryHeaderWidget(
        name: state.chapterModel!.list![section].name,
      ),
      //占位Placeholder
      emptyPlaceholder: () {
        return BookDirectoryItemWidget();
      },
    );
  }
}
