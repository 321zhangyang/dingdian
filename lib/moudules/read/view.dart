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
        return WillPopScope(
          onWillPop: ()  async{
            if (await logic
                      .exitsInBookShelfById(logic.state.bookModel!.id!) ==
                  false) {
                await logic.confirmAddToShelf(context);
              }
            return true;
          },
          child: Scaffold(
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
                  //???????????????
                  Offstage(
                      offstage: logic.state.offstage,
                      child: ReadOffstageWidget())
                ],
              )),
        );
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

    //?????????Controller??????animation
    if (_controller == null) {
      _controller = AnimationController(
          vsync: this,
          duration: Duration(
              milliseconds: state.configModel!.turnType == 0 ? 0 : 300));
      _animation = CurvedAnimation(parent: _controller!, curve: Curves.linear);
    }
    //??????????????????
    _controller?.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        //????????????????????????????????????
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
                  '???${state.bookModel!.cChapterPage! + 1}/${state.cContentModel!.pages!.length}???',
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
  // ?????????????????????
  bool get isNext => !(curChapterIndex < lastChapterIndex! ||
      (curChapterIndex == lastChapterIndex &&
          lastPageIndex! > state.bookModel!.cChapterPage!));
}
