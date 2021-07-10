import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dingdian/constant/constants.dart';
import 'package:flutter_dingdian/moudules/read/model/content_model.dart';
import 'package:flutter_dingdian/utils/text/text_composition.dart';
import 'package:fun_flutter_kit/fun_flutter_kit.dart';
import 'package:get/get.dart';

import 'logic.dart';
import 'state.dart';

class BookReadPage extends StatelessWidget {
  final BookReadLogic logic = Get.put(BookReadLogic());
  final BookReadState state = Get.find<BookReadLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: FunStateObx(
          controller: logic,
          builder: () {
            int itemCount = state.cContentModel!.pages!.length +
                (state.pContentModel != null
                    ? state.pContentModel!.pages!.length
                    : 0) +
                (state.nContentModel != null
                    ? state.nContentModel!.pages!.length
                    : 0);
            print("itemCount$itemCount");
            return Container(
              child: Stack(
                children: [
                  Positioned(
                      child: GestureDetector(
                    child: PageView.builder(
                      physics: BouncingScrollPhysics(),
                      controller: state.pageController,
                      itemCount: itemCount,
                      itemBuilder: (context, index) {
                        var page = index -
                            (state.pContentModel != null
                                ? state.pContentModel!.pages!.length
                                : 0);
                        BookChapterContentModel model;
                        if (page >= state.cContentModel!.pages!.length) {
                          // 到达下一章了
                          model = state.nContentModel!;
                          page = 0;
                        } else if (page < 0) {
                          // 到达上一章了
                          model = state.pContentModel!;
                          page = state.pContentModel!.pages!.length - 1;
                        } else {
                          model = state.cContentModel!;
                        }
                        TextPage textpage = model.pages![page];
                        return Container(
                          height: ScreenUtil.getInstance().screenHeight,
                          width: ScreenUtil.getInstance().screenWidth,
                          decoration: BoxDecoration(color: Colors.white),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height:
                                    ScreenUtil.getInstance().statusBarHeight -
                                        20,
                              ),
                              Gaps.vGap5,
                              Container(
                                padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                                child: Text(model.cname ?? ""),
                                height: 20,
                              ),
                              CustomPaint(
                                painter: PagePainter(
                                  index,
                                  textpage,
                                  logic.state.contentStyle,
                                  logic.state.titleStyle,
                                ),
                              ),
                              Spacer(),
                              Container(
                                height: 30,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
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
                                      '第${page + 1}/${model.pages!.length}页',
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
                                height:
                                    ScreenUtil.getInstance().bottomBarHeight,
                              )
                            ],
                          ),
                        );
                      },
                    ),
                  ))
                ],
              ),
            );
          },
        ));
  }
}
