import 'dart:typed_data';

import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_dingdian/constant/colors.dart';
import 'package:flutter_dingdian/local/local_config_repository.dart';
import 'package:flutter_dingdian/moudules/detail/api/repository.dart';
import 'package:flutter_dingdian/moudules/detail/model/directory_model.dart';
import 'package:flutter_dingdian/moudules/detail/model/info_model.dart';
import 'package:flutter_dingdian/moudules/read/api/repository.dart';
import 'package:flutter_dingdian/moudules/read/model/config_model.dart';
import 'package:flutter_dingdian/moudules/read/model/content_model.dart';
import 'package:flutter_dingdian/moudules/read/model/font_model.dart';
import 'package:flutter_dingdian/moudules/shelf/logic.dart';
import 'package:flutter_dingdian/utils/cache/cache_util.dart';
import 'package:flutter_dingdian/utils/db/DbHelper.dart';
import 'package:flutter_dingdian/utils/text/text_composition.dart';
import 'package:fun_flutter_kit/fun_flutter_kit.dart';
import 'package:get/get.dart';

import 'state.dart';

class BookReadLogic extends FunStateActionController {
  final state = BookReadState();
  final _chapterRepository = Get.put(BookDetailInfoRepository());
  final _contentRepository = Get.put(BookReadRepository());

  //获取图书记录等信息
  getBookRecord() async {
    await getBookChapters();
    resetContent(state.bookModel!.cChapter!);
  }

  //获取所有章节
  getBookChapters() async {
    //拼接地址 id删除后三位 将剩余的id + 1,然后再拼接
    String bookId = state.bookModel!.id.toString();
    int index = int.parse(bookId.substring(0, bookId.length - 3)) + 1;
    String url = "$index/$bookId/index.html";
    BookDirectoryModel model = await _chapterRepository.getBookDirectory(url);
    state.chapterModel = model;
    List<TwoList> allChapters = [];
    //将所有可阅读的章节,分离出来,方便取用,以及跳转
    for (OneList one in state.chapterModel!.list!) {
      for (TwoList two in one.list!) {
        allChapters.add(two);
      }
    }

    //获取所有存储的章节内容
    List tempChapters =
        await DbHelper.instance.getChapters(state.bookModel!.id!);
    //如果存储的内容小于现在获取的 就更新一下
    if (tempChapters.length < allChapters.length) {
      List<TwoList> addChapters = allChapters.sublist(tempChapters.length);
      await DbHelper.instance.addChapters(addChapters, int.parse(bookId));
    }
    state.allChapters = await DbHelper.instance.getChapters(int.parse(bookId));
    state.dirChapters = state.allChapters;
  }

  //选择章节的操作
  changeChapter(int index) {
    state.bookModel!.cChapter = index;
    state.bookModel!.cChapterPage = 0;
    state.lastPage = null;
    resetContent(index);
  }

  //重置内容
  resetContent(int index) async {
    state.cContentModel = await getBookChapterContent(
        state.allChapters[index].id.toString(), index);
    if (state.cContentModel!.pid! > 0) {
      state.pContentModel = await getBookChapterContent(
          state.cContentModel!.pid.toString(), index - 1);
    } else {
      state.pContentModel = null;
    }
    if (state.cContentModel!.nid! > 0) {
      state.nContentModel = await getBookChapterContent(
          state.cContentModel!.nid.toString(), index + 1);
    } else {
      state.nContentModel = null;
    }
    changeIdle();
    update();
  }

  //获取章节内容
  Future<BookChapterContentModel> getBookChapterContent(
      String chapterId, int index) async {
    TwoList chapter = state.allChapters[index];
    if (chapter.hasContent != 2) {
      //没有内容,网路请求内容,然后数据库保存,存储包括 id 章节内容 前一张 后一张
      //拼接地址 id删除后三位 将剩余的id + 1,然后再拼接
      String bookId = state.bookModel!.id.toString();
      int path = int.parse(bookId.substring(0, bookId.length - 3)) + 1;
      String url = "/$path/$bookId/$chapterId.html";
      BookChapterContentModel model =
          await _contentRepository.getBookChapterContent(url);

      //由于返回的章节头部和尾部带有多余字符,这里除去头部和尾部多余的字符,否则会影响排版
      model.content = model.content?.substring(2);
      model.content = model.content?.replaceAll("\f\t\n", "");
      model.pages = parseContent(model.content ?? "", model.cname ?? "");
      DbHelper.instance.udpChapter(model.content ?? "", model.pid ?? -1,
          model.nid ?? -1, int.parse(chapterId));
      chapter.hasContent = 2;
      return model;
    } else {
      //有内容直接数据库,取出来,构造一个新的contentmodel
      BookChapterContentModel model =
          await DbHelper.instance.getChapter(int.parse(chapterId));
      model.id = state.bookModel!.id;
      model.name = state.bookModel!.name;
      model.pages = parseContent(model.content ?? "", model.cname ?? "");
      return model;
    }
  }

  downloadContent(int start) async {
    for (var i = start; i < state.allChapters.length; i++) {
      TwoList chapter = state.allChapters[i];
      if (chapter.hasContent != 2) {
        String bookId = state.bookModel!.id.toString();
        int path = int.parse(bookId.substring(0, bookId.length - 3)) + 1;
        String url = "/$path/$bookId/${chapter.id}.html";
        //延迟1秒再执行 快速请求过多 会导致返回数据有问题
        await Future.delayed(Duration(seconds: 2));
        BookChapterContentModel model =
            await _contentRepository.getBookChapterContent(url);
        //由于返回的章节头部和尾部带有多余字符,这里除去头部和尾部多余的字符,否则会影响排版
        model.content = model.content?.substring(2);
        model.content = model.content?.replaceAll("\f\t\n", "");
        DbHelper.instance.udpChapter(
            model.content ?? "", model.pid ?? -1, model.nid ?? -1, chapter.id!);
      } else {
        print("已下载 : ${chapter.name}");
      }
    }
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
    var curWid = details.globalPosition.dx;
    var curH = details.globalPosition.dy;
    if ((curWid > 0 && curWid < space)) {
      changeCoverPage(-1);
    } else if ((curWid > space) &&
        (curWid < 2 * space) &&
        (curH < hSpace * 3)) {
      print("展示菜单");
      showMenu();
    } else if ((curWid > space * 2)) {
      changeCoverPage(1);
    }
  }

  //换页操作
  Future<void> changeCoverPage(var offsetDifference) async {
    int idx = state.bookModel?.cChapterPage ?? 0;
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
        state.bookModel?.cChapterPage = 0;
        update();

        if (state.cContentModel!.nid! > 0) {
          state.nContentModel = await getBookChapterContent(
              state.cContentModel!.nid.toString(), tempCur + 1);
        } else {
          state.nContentModel = null;
        }
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
        state.pContentModel = await getBookChapterContent(
            state.cContentModel!.pid.toString(), tempCur - 1);
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
    // //将章节信息进行存储
    state.positive = !state.positive;
    state.dirChapters = state.dirChapters.reversed.toList();
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

  //更换字体
  changeFontFamily(String fontFamily) {
    if (fontFamily != "Roboto") {
      readFont(fontFamily);
    }
    state.configModel!.fontFamily = fontFamily;
    state.configModel!.save();
    changeTextContent();
    update();
  }

  //更改完成设置后,重新处理文字内容
  changeTextContent() {
    state.contentStyle = TextStyle(
        fontSize: state.configModel!.font!.toDouble(),
        color: MyColors.text_color,
        height: state.configModel!.height,
        fontFamily: state.configModel!.fontFamily);
    state.titleStyle = TextStyle(
        fontSize: 30,
        color: MyColors.text_color,
        fontWeight: FontWeight.bold,
        fontFamily: state.configModel!.fontFamily);
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
    state.lastPage = null;
    update();
  }

  //切换主题
  changeTheme(String theme) async {
    state.configModel!.theme = theme;
    state.configModel!.save();
    state.lastPage = null;
    update();
  }

  //切换换页方式
  changeTurnType(int index) {
    state.configModel!.turnType = index;
    update();
  }

  // 状态保存.保存阅读信息
  saveReadRecord() {
    //更新数据库内容
    DbHelper.instance.updBookProcess(state.bookModel!.cChapter!,
        state.bookModel!.cChapterPage!, state.bookModel!.id!);
    //刷新书架页面内容
    Get.find<BookShelfLogic>().sort(state.bookModel!);
    Get.find<BookShelfLogic>().pullToRefresh();
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

                      //更新书架以及详情页面状态
                      Get.find<BookShelfLogic>().pullToRefresh();
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
    List<BookDetailInfoModel> books = await DbHelper.instance.getBooks();
    return books.map((e) => e.id).toList().contains(bookId);
  }

  //保存字体
  saveFontFamily(String url, String key) async {
    try {
      await CatcheUtil.instanceFont.downloadFile(url, key: key);
      state.fontList = await fetchFontData();
      update();
    } catch (e) {
      throw (e);
    }
  }

  //获取字体资源
  Future<List<FontInfoModel>> fetchFontData() async {
    List<FontInfoModel> fontInfos = [];
    for (int i = 0; i < state.fonts.length; i++) {
      String key = state.fonts.keys.elementAt(i);
      String value = state.fonts.values.elementAt(i);
      var fileInfo2 = await _getFileInfo(key);
      fontInfos.add(FontInfoModel(key, value, fileInfo2));
    }
    return fontInfos;
  }

  //读取字体
  Future<void> readFont(String fontName) async {
    FileInfo? file = await CatcheUtil.instanceFont.getFileFromCache(fontName);
    var fontLoader = FontLoader(fontName);
    Uint8List readAsBytes = file!.file.readAsBytesSync();

    fontLoader.addFont(Future.value(ByteData.view(readAsBytes.buffer)));
    await fontLoader.load();
  }
//

  Future<FileInfo?> _getFileInfo(String key) async {
    return await CatcheUtil.instanceFont.getFileFromCache(key);
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
      model.turnType = 0;
      model.fontFamily = "Roboto";
      LocalBookConfigRepository.saveBookReadConfig(model);
      state.configModel = model;
    } else {
      state.configModel = configModel;
    }
    state.titleStyle = TextStyle(
        fontSize: 30,
        color: MyColors.text_color,
        fontWeight: FontWeight.bold,
        fontFamily: configModel.fontFamily);
    state.contentStyle = TextStyle(
        fontSize: state.configModel!.font!.toDouble(),
        color: MyColors.text_color,
        height: state.configModel!.height,
        fontFamily: configModel.fontFamily);
    getBookRecord();
    state.fontList = await fetchFontData();
  }

  @override
  Future onLoadData() {
    return getBookChapters();
  }
}
