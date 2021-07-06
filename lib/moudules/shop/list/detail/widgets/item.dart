import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dingdian/constant/constants.dart';
import 'package:flutter_dingdian/moudules/shop/list/detail/logic.dart';
import 'package:flutter_dingdian/moudules/shop/list/model/detail_model.dart';
import 'package:flutter_dingdian/utils/image/image_utils.dart';
import 'package:flutter_dingdian/utils/image/load_image.dart';
import 'package:get/get.dart';

class ShopBookListDetailItem extends StatelessWidget {
  final BookList? model;
  ShopBookListDetailItem({Key? key, this.model}) : super(key: key);
  final _logic = Get.find<ShopBookListDetailLogic>();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _logic.jumpToDetail(model!.bookId.toString()),
          child: Container(
          padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
          color: Colors.white,
          child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            LoadImage(
              ImageUtils.getNetWorkPath(model?.bookImage ?? ""),
              holderImg: "app_placeholder",
              width: 80,
              height: 80 * 1.35,
            ),
            Gaps.hGap15,
            Expanded(
                        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Gaps.vGap10,
                Row(
                  children: [
                    Text(model?.bookName ?? "",
                        style: TextStyle(
                            fontSize: Dimensions.font_sp16,
                            color: MyColors.text_color)),
                            Spacer(),
                    Text("${model?.score} 分",style: TextStyle(fontSize: Dimensions.font_sp16,color: MyColors().getThemeColor()),)        
                  ],
                ),
                Gaps.vGap10,
                Text(
                  "${model?.categoryName} | ${model?.author}",
                  style: TextStyle(
                      fontSize: Dimensions.font_sp14,
                      color: MyColors.text_gray_color),
                ),
                Gaps.vGap10,
                Text(
                  model?.description ?? "",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: Dimensions.font_sp12,
                      color: MyColors.text_gray_color),
                )
              ]),
            ),
          ])),
    );
  }
}
