import 'package:flutter/material.dart';
import 'package:flutter_dingdian/constant/constants.dart';
import 'package:flutter_dingdian/utils/image/image_utils.dart';
import 'package:flutter_dingdian/utils/image/load_image.dart';


class BookSearchResultListItem extends StatelessWidget {
  BookSearchResultListItem({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => null,
          child: Container(
          padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
          color: Colors.white,
          child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
            LoadImage(
              ImageUtils.getNetWorkPath(""),
              holderImg: "app_placeholder",
              width: 80,
              height: 80 * 1.35,
            ),
            Gaps.hGap15,
            Expanded(
                        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Gaps.vGap10,
                Text("哈哈哈",
                    style: TextStyle(
                        fontSize: Dimensions.font_sp16,
                        color: MyColors.text_color)),
                Gaps.vGap10,
                Text(
                  "玄幻奇幻 | 我家的哈士奇",
                  style: TextStyle(
                      fontSize: Dimensions.font_sp14,
                      color: MyColors.text_gray_color),
                ),
                Gaps.vGap10,
                Text(
                  "哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: Dimensions.font_sp12,
                      color: MyColors.text_gray_color),
                )
              ]),
            ),
            Gaps.hGap10,
            Container(
              alignment: Alignment.center,
              width: 40,
              height: 40,
              child: LoadAssetImage("search_plus_Normal"),
            )
          ])),
    );
  }
}
