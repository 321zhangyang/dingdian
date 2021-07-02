import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dingdian/constant/colors.dart';
import 'package:flutter_dingdian/constant/dimensions.dart';
import 'package:flutter_dingdian/constant/gaps.dart';
import 'package:flutter_dingdian/moudules/detail/detail/logic.dart';
import 'package:flutter_dingdian/moudules/detail/model/info_model.dart';
import 'package:flutter_dingdian/utils/image/image_utils.dart';
import 'package:flutter_dingdian/utils/image/load_image.dart';
import 'package:get/get.dart';

class BookDetailSameAuthorWidget extends StatelessWidget {
  final BookDetailLogic _logic = Get.find<BookDetailLogic>();
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.fromLTRB(15, 10, 15, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            alignment: Alignment.centerLeft,
            height: 30,
            child: Text(
              "作者还写过",
              style: TextStyle(
                  fontSize: Dimensions.font_sp16, color: MyColors.text_color),
            ),
          ),
          Divider(
            height: 1,
          ),
          ListView.separated(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                SameUserBooks books = _logic.state.model!.sameUserBooks![index];
                return Container(
                  padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      LoadImage(
                        ImageUtils.getNetWorkPath(
                            books.img ?? ""),
                        holderImg: "app_placeholder",
                        width: 100,
                        height: 100 * 1.35,
                      ),
                      Gaps.hGap15,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Gaps.vGap15,
                          Text(
                            books.name ?? "哈哈哈",
                            style: TextStyle(
                                fontSize: Dimensions.font_sp18,
                                color: MyColors.text_color,
                                fontWeight: FontWeight.w500),
                          ),
                          Gaps.vGap8,
                          Text(
                            "作者: ${books.author}",
                            style: TextStyle(
                                fontSize: Dimensions.font_sp14,
                                color: MyColors.text_color),
                          ),
                          Gaps.vGap8,
                          Text(
                            books.lastChapter ?? "",
                            style: TextStyle(
                                fontSize: Dimensions.font_sp14,
                                color: MyColors.text_gray_color),
                          ),
                        ],
                      )
                    ],
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return Divider();
              },
              itemCount: _logic.getSameUsersLength()),
          _logic.state.model!.sameUserBooks!.length > 3
              ? Divider(
                  height: 1,
                )
              : Container(),
          _logic.state.model!.sameUserBooks!.length > 3
              ? GestureDetector(
                  onTap: () => _logic.showSameUser(),
                  child: Container(
                    alignment: Alignment.center,
                    height: 44,
                    color: Colors.white,
                    width: ScreenUtil.getInstance().screenWidth,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          _logic.state.showAllUser == true ? "收起" : "更多",
                          style: TextStyle(
                              fontSize: Dimensions.font_sp16,
                              color: MyColors.text_color),
                        ),
                        Gaps.hGap10,
                        LoadAssetImage(_logic.state.showAllUser == false
                            ? "sj_more_arrow_Normal"
                            : "sj_fold_arrow_Normal")
                      ],
                    ),
                  ),
                )
              : Container()
        ],
      ),
    );
  }
}
