import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dingdian/constant/colors.dart';
import 'package:flutter_dingdian/constant/dimensions.dart';
import 'package:flutter_dingdian/constant/gaps.dart';
import 'package:flutter_dingdian/moudules/shop/choose/choose/logic.dart';
import 'package:flutter_dingdian/moudules/shop/choose/model/choose_model.dart';
import 'package:flutter_dingdian/utils/image/image_utils.dart';
import 'package:flutter_dingdian/utils/image/load_image.dart';
import 'package:get/get.dart';

class ShopChooseItem extends StatelessWidget {
  final BookChooseModel? model;
  final _logic = Get.find<ShopChooseLogic>();
  final double imageWidth = (ScreenUtil.getInstance().screenWidth - 90) / 3;

  ShopChooseItem({Key? key, this.model}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(15, 10, 15, 5),
      child: Column(
        children: [
          buildHeader(),
          model!.books!.length > 6 ? buildTopItem() : Container(),
          buildNormalItem()
        ],
      ),
    );
  }

  //顶部item
  Container buildTopItem() {
    Books books = model!.books!.first;
    return Container(
      padding: EdgeInsets.fromLTRB(0, 15, 0, 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          LoadImage(
            ImageUtils.getNetWorkPath(books.img ?? ""),
            holderImg: "app_placeholder",
            width: imageWidth,
            height: imageWidth * 1.3,
          ),
          Gaps.hGap15,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  books.name ?? "",
                  style: TextStyle(fontSize: Dimensions.font_sp16),
                  maxLines: 1,
                ),
                Gaps.vGap10,
                Text(
                  books.desc ?? "",
                  style: TextStyle(
                      fontSize: Dimensions.font_sp14,
                      color: MyColors.text_gray_color),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                Gaps.vGap10,
                Row(
                  children: [
                    Text(
                      books.author ?? "",
                      style: TextStyle(
                          fontSize: Dimensions.font_sp14,
                          color: MyColors.text_gray_color),
                      maxLines: 1,
                    ),
                    Spacer(),
                    Text(
                      books.score ?? "",
                      style: TextStyle(
                          fontSize: Dimensions.font_sp14,
                          color: Color.fromRGBO(247, 143, 44, 1)),
                    )
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
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
            mainAxisSpacing: 10,
            crossAxisSpacing: 30,
            childAspectRatio: 0.5),
        itemCount: 6,
        itemBuilder: (context, index) {
          Books books =
              model!.books![model!.books!.length > 6 ? index + 1 : index];
          return GestureDetector(
              onTap: () {
                
              },
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
                  Gaps.vGap5,
                  Text(
                    books.author ?? "",
                    style: TextStyle(
                        fontSize: Dimensions.font_sp14,
                        color: MyColors.text_gray_color),
                    maxLines: 1,
                  ),
                ],
              ));
        },
      ),
    );
  }

  //头部
  Container buildHeader() {
    return Container(
      child: Row(
        children: [
          LoadAssetImage(
            "recommend5",
            width: 20,
            height: 20,
          ),
          Gaps.hGap10,
          Text(
            model!.category ?? "",
            style: TextStyle(
                fontSize: Dimensions.font_sp18, fontWeight: FontWeight.w400),
          ),
          Spacer(),
          GestureDetector(
            onTap: () => _logic.jumpToMore(model!.category ?? "", model!.more ?? ""),
            child: Container(
              width: 50,
              height: 30,
              alignment: Alignment.centerRight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "更多",
                    style: TextStyle(
                        fontSize: Dimensions.font_sp14,
                        color: MyColors.text_gray_color),
                  ),
                  Gaps.hGap5,
                  LoadAssetImage("more_arrow_Normal")
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
