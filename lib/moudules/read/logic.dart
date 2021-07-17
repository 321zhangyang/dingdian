import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dingdian/constant/colors.dart';
import 'package:flutter_dingdian/local/local_config_repository.dart';
import 'package:flutter_dingdian/moudules/detail/api/repository.dart';
import 'package:flutter_dingdian/moudules/detail/direcory/widgets/header.dart';
import 'package:flutter_dingdian/moudules/detail/direcory/widgets/item.dart';
import 'package:flutter_dingdian/moudules/detail/model/directory_model.dart';
import 'package:flutter_dingdian/moudules/detail/model/info_model.dart';
import 'package:flutter_dingdian/moudules/read/api/repository.dart';
import 'package:flutter_dingdian/moudules/read/model/config_model.dart';
import 'package:flutter_dingdian/moudules/read/model/content_model.dart';
import 'package:flutter_dingdian/utils/db/DbHelper.dart';
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
    String bookId = state.bookModel!.id.toString();
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
    //将章节信息进行存储
    _initGroupHandler();
    resetContent(state.bookModel!.cChapter!);
  }

  //重置内容
  resetContent(int index) async {
    state.cContentModel =
        await getBookChapterContent(state.allChapters[index].id.toString());
    if (state.cContentModel!.pid! > 0) {
      state.pContentModel =
          await getBookChapterContent(state.cContentModel!.pid.toString());
    } else {
      state.pContentModel = null;
    }
    if (state.cContentModel!.nid! > 0) {
      state.nContentModel =
          await getBookChapterContent(state.cContentModel!.nid.toString());
    } else {
      state.nContentModel = null;
    }
    changeIdle();
    update();
  }

  //获取章节内容
  Future<BookChapterContentModel> getBookChapterContent(
      String chapterId) async {
    //拼接地址 id删除后三位 将剩余的id + 1,然后再拼接
    String bookId = state.bookModel!.id.toString();
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

  // 切换页面
  tapPage(BuildContext context, TapDownDetails details) {
    var wid = ScreenUtil.getScreenW(context);
    var hSpace = ScreenUtil.getInstance().screenHeight / 4;
    var space = wid / 3;
    print(space);
    var curWid = details.globalPosition.dx;
    print(curWid);
    var curH = details.globalPosition.dy;

    if ((curWid > 0 && curWid < space)) {
      print("前一页");
      changeCoverPage(-1);
    } else if ((curWid > space) &&
        (curWid < 2 * space) &&
        (curH < hSpace * 3)) {
      print("展示菜单");
      showMenu();
    } else if ((curWid > space * 2)) {
      print("后一页");
      changeCoverPage(1);
    }
  }

  //换页操作
  Future<void> changeCoverPage(var offsetDifference) async {
    int idx = state.bookModel?.cChapterPage ?? 0;
    print(idx);
    int curLen = (state.cContentModel?.pages?.length ?? 0);
    if (idx == curLen - 1 && offsetDifference > 0) {
      int tempCur = state.bookModel!.cChapter! + 1;
      if (tempCur >= state.allChapters.length) {
        print("已经是最后一章");
        return;
      } else {
        state.bookModel!.cChapter = state.bookModel!.cChapter! + 1;
        state.pContentModel = state.cContentModel;
        state.cContentModel = state.nContentModel;
        if (state.cContentModel!.nid! > 0) {
          state.nContentModel =
              await getBookChapterContent(state.cContentModel!.nid.toString());
        } else {
          state.nContentModel = null;
        }
        state.bookModel?.cChapterPage = 0;
        update();
        return;
      }
    }

    if (idx == 0 && offsetDifference < 0) {
      int tempCur = state.bookModel!.cChapter! - 1;
      if (tempCur < 0) {
        print("第一页");
        return;
      }
      state.nContentModel = state.cContentModel;
      state.cContentModel = state.pContentModel;
      state.bookModel!.cChapter = state.bookModel!.cChapter! - 1;
      state.bookModel!.cChapterPage = state.cContentModel!.pages!.length - 1;
      update();
      if (state.cContentModel!.pid! > 0) {
        state.pContentModel =
            await getBookChapterContent(state.cContentModel!.pid.toString());
      } else {
        state.pContentModel = null;
      }
      return;
    }

    if (offsetDifference > 0) {
      state.bookModel!.cChapterPage = state.bookModel!.cChapterPage! + 1;
    } else {
      state.bookModel!.cChapterPage = state.bookModel!.cChapterPage! - 1;
    }
    update();
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

  //切换行间距
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

  // 状态保存.保存阅读信息
  saveReadRecord() {
    DbHelper.instance.updBookProcess(state.bookModel!.cChapter!,
        state.bookModel!.cChapterPage!, state.bookModel!.id!);
  }

  //是否提示添加书架
  Future confirmAddToShelf(BuildContext context) async {
    await showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: Text('是否加入本书'),
              actions: <Widget>[
                TextButton(
                    onPressed: () async {
                      await DbHelper.instance.addBooks([state.bookModel!]);
                      Navigator.pop(context);
                      Get.back();
                      //在这要刷新详情页以及书架页面
                    },
                    child: Text('确定')),
                TextButton(
                    onPressed: () async {
                      Navigator.pop(context);
                      Get.back();
                    },
                    child: Text('取消')),
              ],
            ));
  }

  //判断书架是否有本书
  Future<bool> exitsInBookShelfById(int bookId) async {
    List<BookDetailInfoModel> books =
        await DbHelper.instance.getBooks(state.bookModel!.id!);
    return books.map((e) => e.id).toList().contains(bookId);
  }

  @override
  void onInit() async {
    super.onInit();
    changeLoading();
    state.bookModel = Get.arguments["model"];
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
        onTap: () async {
          print("indexPath.row ${indexPath.row}");
          state.bookModel!.cChapter = indexPath.row;
          print("state.bookModel! ${state.bookModel!.cChapter}");
          state.bookModel!.cChapterPage = 0;
          await resetContent(indexPath.row);

          Navigator.pop(state.readKey.currentContext!);
        },
        child: BookDirectoryItemWidget(
            item: state
                .chapterModel!.list![indexPath.section].list![indexPath.row],
            select: indexPath.row == state.bookModel!.cChapter),
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
