import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dingdian/constant/colors.dart';
import 'package:flutter_dingdian/constant/dimensions.dart';
import 'package:flutter_dingdian/moudules/detail/detail/widgets/autor.dart';
import 'package:flutter_dingdian/moudules/detail/detail/widgets/category.dart';
import 'package:flutter_dingdian/moudules/detail/detail/widgets/directory.dart';
import 'package:flutter_dingdian/moudules/detail/detail/widgets/info.dart';
import 'package:fun_flutter_kit/state/src/controller/fun_state_obx.dart';
import 'package:get/get.dart';

import 'logic.dart';

class BookDetailPage extends StatefulWidget {
  @override
  _BookDetailPageState createState() => _BookDetailPageState();
}

class _BookDetailPageState extends State<BookDetailPage> {
  final BookDetailLogic _logic = Get.put(BookDetailLogic());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: FunStateObx(
        controller: _logic,
        builder: () => Container(
          height: ScreenUtil.getInstance().screenHeight,
          width: ScreenUtil.getInstance().screenWidth,
          child: Stack(
            children: [
              Positioned(
                top: 0,
                bottom: 50,
                width: ScreenUtil.getInstance().screenWidth,
                child: MediaQuery.removePadding(
                    context: context,
                    removeTop: true,
                    child: Container(
                      child: NotificationListener(
                          onNotification: (notification) {
                            if (notification is ScrollUpdateNotification &&
                                notification.depth == 0) {
                              _logic.onScroll(notification.metrics.pixels);
                            }
                            return true;
                          },
                          child: ListView.separated(
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              if (index == 0) {
                                return BookDetailInfoWidget();
                              } else if (index == 1) {
                                return BookDetailDirectoryWidget();
                              } else if (index == 2) {
                                return _logic.state.model!.sameUserBooks!
                                            .length >
                                        0
                                    ? BookDetailSameAuthorWidget()
                                    : Container();
                              } else {
                                return BookDetailSameCategoryWidget();
                              }
                            },
                            separatorBuilder: (context, index) {
                              return Container(
                                  height: 5,
                                  color: Color.fromRGBO(240, 240, 240, 1));
                            },
                            itemCount: 4,
                          )),
                    )),
              ),
              Opacity(
                  opacity: _logic.state.alpha, //滑动offset改变透明度
                  child: Container(
                    child: AppBar(),
                    height: ScreenUtil.getInstance().appBarHeight +
                        ScreenUtil.getInstance().statusBarHeight,
                    color: MyColors().getThemeColor(),
                  )),
              Positioned(
                bottom: 0,
                child: Container(
                  child: Row(
                    children: [
                      Container(
                        alignment: Alignment.center,
                        width: ScreenUtil.getInstance().screenWidth / 2,
                        height: ScreenUtil.getInstance().bottomBarHeight + 40,
                        color: Colors.white,
                        child: Text(
                          "移除书架",
                          style: TextStyle(
                              fontSize: Dimensions.font_sp16,
                              color: Color.fromRGBO(252, 53, 71, 1),
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        width: ScreenUtil.getInstance().screenWidth / 2,
                        height: ScreenUtil.getInstance().bottomBarHeight + 40,
                        color: Color.fromRGBO(252, 53, 71, 1),
                        child: Text(
                          "立即阅读",
                          style: TextStyle(
                              fontSize: Dimensions.font_sp16,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
