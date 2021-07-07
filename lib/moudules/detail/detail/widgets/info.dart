import 'dart:ui';

import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_dingdian/constant/dimensions.dart';
import 'package:flutter_dingdian/constant/gaps.dart';
import 'package:flutter_dingdian/moudules/detail/detail/logic.dart';
import 'package:flutter_dingdian/utils/image/image_utils.dart';
import 'package:flutter_dingdian/utils/image/load_image.dart';
import 'package:flutter_dingdian/utils/text/expandableText.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';

class BookDetailInfoWidget extends StatelessWidget {
    final BookDetailLogic _logic = Get.find<BookDetailLogic>();
    @override
    Widget build(BuildContext context) {
      return Column(
        children: [
          buildInfoWidget(),
          Container(
            color: Colors.white,
            padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
            child:  TQExpandableText(
            _logic.state.model!.desc ?? "",
            expandText: '全文',
            maxLines: 3,
            collapseText: '收起') ,
          )
        ],
      );
    }

    Container buildInfoWidget() {
      return Container(
          child: Stack(
            children: [
              Container(
                width: ScreenUtil.getInstance().screenWidth,
                height: 300,
                child: LoadImage(
                ImageUtils.getNetWorkPath(_logic.state.model!.img ?? ""),
                holderImg: "app_placeholder",
              ),
              ),
              Center(
                child: ClipRect(
                    child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                  child: Opacity(
                    opacity: 0.7,
                    child: Container(
                      width: ScreenUtil.getInstance().screenWidth,
                      height: 300,
                      decoration: BoxDecoration(color: Colors.black),
                    ),
                  ),
                )),
              ),
              Positioned(
                top: ScreenUtil.getInstance().appBarHeight +
                    ScreenUtil.getInstance().statusBarHeight,
                child: Container(
                  width: ScreenUtil.getInstance().screenWidth,
                  height: 300 -
                      ScreenUtil.getInstance().appBarHeight -
                      ScreenUtil.getInstance().statusBarHeight,
                  color: Colors.transparent,
                  child: Container(
                    padding: EdgeInsets.fromLTRB(15, 10, 15, 0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        LoadImage(
                          ImageUtils.getNetWorkPath(_logic.state.model!.img ?? ""),
                          holderImg: "app_placeholder",
                          width: 100,
                          height: 100 * 1.35,
                        ),
                        Gaps.hGap15,
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _logic.state.model!.name ?? "",
                              style: TextStyle(
                                  fontSize: Dimensions.font_sp18,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            Gaps.vGap8,
                            Text(
                              _logic.state.model!.author ?? "",
                              style: TextStyle(
                                  fontSize: Dimensions.font_sp14,
                                  color: Colors.white),
                            ),
                            Gaps.vGap8,
                            Text(
                              _logic.state.model!.cName ?? "",
                              style: TextStyle(
                                  fontSize: Dimensions.font_sp14,
                                  color: Colors.white),
                            ),
                            Gaps.vGap8,
                            Text(
                              "状态: ${_logic.state.model!.bookStatus ?? ""}",
                              style: TextStyle(
                                  fontSize: Dimensions.font_sp14,
                                  color: Colors.white),
                            ),
                            Gaps.vGap8,
                            Row(
                              children: [
                                RatingBarIndicator(
                                  rating: _logic.state.model!.bookVote!.score! / 2,
                                  itemBuilder: (context, index) => Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                  ),
                                  itemCount: 5,
                                  itemSize: 15.0,
                                  unratedColor: Colors.amber.withAlpha(50),
                                  direction: Axis.horizontal,
                                ),
                                Gaps.hGap5,
                                Text(
                                  "${_logic.state.model!.bookVote!.score.toString()}分",
                                  style: TextStyle(
                                      fontSize: Dimensions.font_sp14,
                                      color: Colors.white),
                                )
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
    }
  }
  
