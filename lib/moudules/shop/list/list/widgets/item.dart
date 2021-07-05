import 'package:flutter/material.dart';
import 'package:flutter_dingdian/constant/colors.dart';
import 'package:flutter_dingdian/constant/dimensions.dart';
import 'package:flutter_dingdian/constant/gaps.dart';
import 'package:flutter_dingdian/moudules/shop/choose/model/list_model.dart';
import 'package:flutter_dingdian/moudules/shop/list/model/list_model.dart';
import 'package:flutter_dingdian/utils/image/image_utils.dart';
import 'package:flutter_dingdian/utils/image/load_image.dart';

class ShopBookListItem extends StatelessWidget {
  final ShopBookListModel? model;

  const ShopBookListItem({Key? key, this.model}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(15, 15, 15, 10),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model?.title ?? "",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: Dimensions.font_sp18,
                      color: MyColors.text_color,
                      fontWeight: FontWeight.bold),
                ),
                Gaps.vGap8,
                Text(
                  model?.description ?? "",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: Dimensions.font_sp14,
                      color: MyColors.text_gray_color),
                ),
                Gaps.vGap20,
                Text(
                  "共${model?.bookCount}本书",
                  style: TextStyle(
                      fontSize: Dimensions.font_sp14,
                      color: MyColors.text_color),
                )
              ],
            ),
          ),
          Gaps.hGap20,
          Expanded(
            flex: 1,
            child: LoadImage(
              ImageUtils.getNetWorkPath(model?.cover ?? ""),
              holderImg: "app_placeholder",
              width: 65,
              height: 85 * 1.3,
              fit: BoxFit.contain,
            ),
          ),
        ],
      ),
    );
  }
}
