import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dingdian/constant/constants.dart';
import 'package:flutter_dingdian/moudules/read/model/content_model.dart';
import 'package:flutter_dingdian/moudules/read/widgets/bottom.dart';
import 'package:flutter_dingdian/moudules/read/widgets/directory.dart';
import 'package:flutter_dingdian/moudules/read/widgets/offstage.dart';
import 'package:flutter_dingdian/utils/image/image_utils.dart';
import 'package:flutter_dingdian/utils/text/text_composition.dart';
import 'package:fun_flutter_kit/fun_flutter_kit.dart';
import 'package:get/get.dart';
import 'dart:ui' as ui;

import 'logic.dart';
import 'state.dart';

class BookReadPage extends StatefulWidget {
  @override
  _BookReadPageState createState() => _BookReadPageState();
}

class _BookReadPageState extends State<BookReadPage> {
  final BookReadLogic logic = Get.put(BookReadLogic());

  final BookReadState state = Get.find<BookReadLogic>().state;

  // @override
  // Widget build(BuildContext context) {
  //   return FunStateObx(
  //     controller: logic,
  //     onLoading: Container(),
  //     builder: () {
  //       int itemCount = state.cContentModel!.pages!.length +
  //           (state.pContentModel != null
  //               ? state.pContentModel!.pages!.length
  //               : 0) +
  //           (state.nContentModel != null

  //               ? state.nContentModel!.pages!.length
  //               : 0);
  //               print("itemCount $itemCount");
  //       return Scaffold(
  //           backgroundColor: Colors.white,
  //           key: logic.state.readKey,
  //           drawer: Drawer(
  //             child: ReadDirectoryWidget(),
  //           ),
  //           body: Container(
  //             child: Stack(
  //               children: [
  //                 Positioned(
  //                     child: GestureDetector(
  //                   onTap: () => logic.showMenu(),
  //                   child: PageView.builder(
  //                     physics: BouncingScrollPhysics(),
  //                     controller: state.pageController,
  //                     itemCount: itemCount,
  //                     itemBuilder: (context, index) {
  //                       print("index $index");
  //                       var page = index -
  //                           (state.pContentModel != null
  //                               ? state.pContentModel!.pages!.length
  //                               : 0);
  //                                print("page $page");
  //                       BookChapterContentModel model;
  //                       if (page >= state.cContentModel!.pages!.length) {
  //                         // 到达下一章了
  //                         model = state.nContentModel!;
  //                         page = 0;
  //                       } else if (page < 0) {
  //                         // 到达上一章了
  //                         model = state.pContentModel!;
  //                         page = state.pContentModel!.pages!.length - 1;
  //                       } else {
  //                         model = state.cContentModel!;
  //                       }
  //                       print("page ==== $page");
  //                       TextPage textpage = model.pages![page];
  //                       return Container(
  //                         height: ScreenUtil.getInstance().screenHeight,
  //                         width: ScreenUtil.getInstance().screenWidth,
  //                         decoration: BoxDecoration(
  //                             image: DecorationImage(
  //                           image: ExactAssetImage(ImageUtils.getImgPath(
  //                               logic.state.configModel!.theme!)),
  //                           fit: BoxFit.fill,
  //                         )),
  //                         child: Column(
  //                           crossAxisAlignment: CrossAxisAlignment.start,
  //                           children: [
  //                             SizedBox(
  //                               height:
  //                                   ScreenUtil.getInstance().statusBarHeight -
  //                                       20,
  //                             ),
  //                             Gaps.vGap5,
  //                             Container(
  //                               padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
  //                               child: Text(model.cname ?? ""),
  //                               height: 20,
  //                             ),
  //                             CustomPaint(
  //                               painter: PagePainter(
  //                                 index,
  //                                 textpage,
  //                                 logic.state.contentStyle,
  //                                 logic.state.titleStyle,
  //                               ),
  //                             ),
  //                             Spacer(),
  //                             Container(
  //                               height: 30,
  //                               padding:
  //                                   const EdgeInsets.symmetric(horizontal: 20),
  //                               child: Row(
  //                                 children: <Widget>[
  //                                   Gaps.hGap10,
  //                                   Text(
  //                                     '${DateUtil.formatDate(DateTime.now(), format: DateFormats.h_m)}',
  //                                     style: TextStyle(
  //                                       fontSize: 12,
  //                                       color: MyColors.text_color,
  //                                     ),
  //                                   ),
  //                                   Spacer(),
  //                                   Text(
  //                                     '第${page + 1}/${model.pages!.length}页',
  //                                     style: TextStyle(
  //                                       fontSize: 12,
  //                                       color: MyColors.text_color,
  //                                     ),
  //                                     textAlign: TextAlign.center,
  //                                   ),
  //                                 ],
  //                               ),
  //                             ),
  //                             SizedBox(
  //                               height:
  //                                   ScreenUtil.getInstance().bottomBarHeight,
  //                             )
  //                           ],
  //                         ),
  //                       );
  //                     },
  //                   ),
  //                 )),
  //                 Offstage(
  //                     offstage: logic.state.offstage,
  //                     child: ReadOffstageWidget())
  //               ],
  //             ),
  //           ));
  //     },
  //   );
  // }

  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    logic.saveReadRecord();
  }

  @override
  Future<void> deactivate() async {
    super.deactivate();

    await logic.saveReadRecord();
  }

  @override
  Widget build(BuildContext context) {
    return FunStateObx(
      controller: logic,
      builder: () {
        return Scaffold(
            backgroundColor: Colors.white,
            key: logic.state.readKey,
            drawer: Drawer(
              child: ReadDirectoryWidget(),
            ),
            body: Stack(
              children: [
                GestureDetector(
                  child: _CoverPage(),
                  onTapDown: (details) => logic.tapPage(context, details),
                  onPanEnd: (details) {
                    var x = details.velocity.pixelsPerSecond.dx < 0 ? 1 : -1;
                    logic.changeCoverPage(x);
                  },
                ),
                //隐藏的菜单
                Offstage(
                    offstage: logic.state.offstage, child: ReadOffstageWidget())
              ],
            ));
      },
    );
  }
}

class _CoverPage extends StatefulWidget {
  final BookReadPage? owner;
  const _CoverPage({Key? key, this.owner}) : super(key: key);

  @override
  __CoverPageState createState() => __CoverPageState();
}

class __CoverPageState extends State<_CoverPage> with TickerProviderStateMixin {
  int? lastPageIndex, lastChapterIndex;
  double x = 0;
  AnimationController? _controller;
  Animation<double>? _animation;
  final BookReadLogic logic = Get.put(BookReadLogic());
  final BookReadState state = Get.find<BookReadLogic>().state;
  @override
  void initState() {
    super.initState();

    //初始化Controller以及animation
    if (_controller == null) {
      _controller = AnimationController(
          vsync: this,
          duration: Duration(
              milliseconds: state.configModel!.turnType == 0 ? 0 : 300));
      _animation = CurvedAnimation(parent: _controller!, curve: Curves.linear);
    }
    //添加状态监听
    _controller?.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        //动画完成后预加载上下页面
        print("here");
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller?.dispose();
    _controller?.removeStatusListener((status) {});
  }

  @override
  Widget build(BuildContext context) {
    if (state.lastPage != null) {
      bool isChangePage = (lastPageIndex != state.bookModel!.cChapterPage! ||
          lastChapterIndex != state.bookModel!.cChapter);
      if (isChangePage) {
        _controller = AnimationController(
          vsync: this,
          duration: Duration(
              milliseconds: state.configModel!.turnType == 0 ? 0 : 300),
        );
        _animation = CurvedAnimation(
          parent: _controller!,
          curve: Curves.linear,
        );
        bool _isNext = isNext;
        var _last = state.lastPage;
        state.lastPage = buildPage();
        if (_isNext)
          _controller!.forward(from: 0.0);
        else
          _controller!.forward(from: -1.2);
        return Stack(
          children: _isNext
              ? [
                  state.lastPage!,
                  SlideTransition(
                      child: _last,
                      position: _animation!.drive(
                          Tween(end: Offset(-1.1, .0), begin: Offset.zero)
                              .chain(CurveTween(curve: Curves.easeIn)))),
                ]
              : [
                  _last!,
                  SlideTransition(
                      position: _animation!.drive(
                          Tween(begin: Offset(-1.1, .0), end: Offset.zero)
                              .chain(CurveTween(curve: Curves.easeIn))),
                      child: state.lastPage)
                ],
        );
      }
      return state.lastPage!;
    }
    state.lastPage = buildPage(firstLoad: true);
    return state.lastPage!;
  }

  Widget buildPage({bool firstLoad = false}) {
    lastPageIndex = state.bookModel!.cChapterPage!;
    lastChapterIndex = state.bookModel!.cChapter!;
    return Container(
      height: ScreenUtil.getInstance().screenHeight,
      width: ScreenUtil.getInstance().screenWidth,
      decoration: BoxDecoration(
          image: DecorationImage(
        image: ExactAssetImage(
            ImageUtils.getImgPath(logic.state.configModel!.theme!)),
        fit: BoxFit.fill,
      )),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: ScreenUtil.getInstance().statusBarHeight - 20,
          ),
          Gaps.vGap5,
          Container(
            padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
            child: Text(state.cContentModel!.cname!),
            height: 20,
          ),
          CustomPaint(
            painter: PagePainter(
              state.bookModel!.cChapterPage!,
              state.cContentModel!.pages![state.bookModel!.cChapterPage!],
              logic.state.contentStyle,
              logic.state.titleStyle,
            ),
          ),
          Spacer(),
          Container(
            height: 30,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: <Widget>[
                Gaps.hGap10,
                Text(
                  '${DateUtil.formatDate(DateTime.now(), format: DateFormats.h_m)}',
                  style: TextStyle(
                    fontSize: 12,
                    color: MyColors.text_color,
                  ),
                ),
                Spacer(),
                Text(
                  '第${state.bookModel!.cChapterPage! + 1}/${state.cContentModel!.pages!.length}页',
                  style: TextStyle(
                    fontSize: 12,
                    color: MyColors.text_color,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          SizedBox(
            height: ScreenUtil.getInstance().bottomBarHeight,
          )
        ],
      ),
    );
  }

  int get curChapterIndex => state.bookModel!.cChapter!;
  // 是否进入下一页
  bool get isNext => !(curChapterIndex < lastChapterIndex! ||
      (curChapterIndex == lastChapterIndex &&
          lastPageIndex! > state.bookModel!.cChapterPage!));
}
