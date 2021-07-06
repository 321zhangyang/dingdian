import 'package:flutter/material.dart';
import 'package:flutter_dingdian/constant/colors.dart';
import 'package:flutter_dingdian/constant/dimensions.dart';
import 'package:flutter_dingdian/constant/gaps.dart';
import 'package:flutter_dingdian/moudules/shop/choose/model/list_model.dart';
import 'package:flutter_dingdian/utils/image/image_utils.dart';
import 'package:flutter_dingdian/utils/image/load_image.dart';

class ShopChooseListItem extends StatelessWidget {
  final BookList? model;

  const ShopChooseListItem({Key? key, this.model}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    print(model?.img ?? "");
    return Container(
      padding: EdgeInsets.fromLTRB(15, 15, 15, 15),
      color: Colors.white,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 100,
            height: 100 * 1.3,
            child: Stack(
              children: [
                LoadImage(
                  ImageUtils.getNetWorkPath(model?.img ?? ""),
                  holderImg: "app_placeholder",
                  width: 100,
                  height: 100 * 1.3,
                ),
                Positioned(
                  child: Container(
                    alignment: Alignment.center,
                    width: 100,
                    height: 35,
                    child: Text(
                      "${model?.score} 分",
                      style: TextStyle(
                          color: Color.fromRGBO(247, 143, 44, 1),
                          fontSize: Dimensions.font_sp15),
                    ),
                    color: Color.fromRGBO(0, 0, 0, 0.5),
                  ),
                  bottom: 0,
                  width: 100,
                ),
              ],
            ),
          ),
          Gaps.hGap10,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model?.name ?? "",
                  style: TextStyle(
                    fontSize: Dimensions.font_sp16,
                    color: MyColors.text_color,
                  ),
                ),
                Gaps.vGap8,
                Text(
                  model?.author ?? "",
                  style: TextStyle(
                      fontSize: Dimensions.font_sp12,
                      color: MyColors.text_gray_color),
                ),
                Gaps.vGap8,
                Text(
                  model?.cName ?? "",
                  style: TextStyle(
                      fontSize: Dimensions.font_sp12,
                      color: MyColors.text_gray_color),
                ),
                Gaps.vGap8,
                Text(
                  model?.desc ?? "",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: Dimensions.font_sp12,
                      color: MyColors.text_gray_color),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
