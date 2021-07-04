import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dingdian/constant/constants.dart';
import 'package:flutter_dingdian/moudules/detail/detail/logic.dart';
import 'package:flutter_dingdian/moudules/detail/model/info_model.dart';
import 'package:flutter_dingdian/utils/image/image_utils.dart';
import 'package:flutter_dingdian/utils/image/load_image.dart';
import 'package:get/get.dart';

class BookDetailSameCategoryWidget extends StatelessWidget {
  final BookDetailLogic _logic = Get.find<BookDetailLogic>();
  final double imageWidth = (ScreenUtil.getInstance().screenWidth - 90) / 3;
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
                "大家还看过",
                style: TextStyle(
                    fontSize: Dimensions.font_sp16, color: MyColors.text_color),
              ),
            ),
            Divider(
              height: 1,
            ),
            buildNormalItem()
          ],
        ));
  }

  //普通item
  Container buildNormalItem() {
    return Container(
      child: GridView.builder(
        padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 0,
            crossAxisSpacing: 30,
            childAspectRatio: 0.55),
        itemCount: 6,
        itemBuilder: (context, index) {
          SameCategoryBooks books =
              _logic.state.model!.sameCategoryBooks![index];
          return GestureDetector(
              onTap: () {
                _logic.jumpToDetail(books.id.toString());
              },
              child: Container(
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    LoadImage(
                      ImageUtils.getNetWorkPath(books.img ?? ""),
                      holderImg: "app_placeholder",
                      width: imageWidth,
                      height: imageWidth * 1.3,
                    ),
                    Gaps.vGap5,
                    Text(
                      books.name ?? "",
                      style: TextStyle(fontSize: Dimensions.font_sp16),
                      maxLines: 1,
                    ),
                  ],
                ),
              ));
        },
      ),
    );
  }
}
