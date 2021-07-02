import 'package:flutter/material.dart';
import 'package:flutter_dingdian/constant/colors.dart';
import 'package:flutter_dingdian/constant/dimensions.dart';
import 'package:flutter_dingdian/constant/gaps.dart';
import 'package:flutter_dingdian/moudules/detail/detail/logic.dart';
import 'package:flutter_dingdian/utils/image/load_image.dart';
import 'package:get/get.dart';

class BookDetailDirectoryWidget extends StatelessWidget {

  final BookDetailLogic _logic = Get.find<BookDetailLogic>();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
      color: Colors.white,
      child: Row(
        children: [
          Text(
            "目录",
            style: TextStyle(
                fontSize: Dimensions.font_sp16, color: MyColors.text_color),
          ),
          Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                _logic.state.model?.lastTime ?? "",
                style: TextStyle(
                    fontSize: Dimensions.font_sp12,
                    color: MyColors.text_gray_color),
              ),
              Gaps.vGap8,
              Text(_logic.state.model?.lastChapter ?? "",style: TextStyle(
                    fontSize: Dimensions.font_sp14,
                    color: MyColors.text_color))
            ],
          ),
          Gaps.hGap10,
          LoadAssetImage("more_arrow_Normal"),
        ],
      ),
    );
  }
}
