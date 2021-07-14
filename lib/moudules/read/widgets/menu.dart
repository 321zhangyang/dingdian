import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dingdian/constant/dimensions.dart';
import 'package:flutter_dingdian/constant/gaps.dart';
import 'package:flutter_dingdian/moudules/read/logic.dart';
import 'package:flutter_dingdian/utils/image/load_image.dart';
import 'package:get/get.dart';

class ReadBottomMenuWidget extends StatelessWidget {
  final BookReadLogic _logic = Get.put(BookReadLogic());
  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil.getInstance().bottomBarHeight + 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          buildBottomMenuItem(
              '目录', "KKStriveImg_readV_catalogue_Normal", context),
          buildBottomMenuItem(
              '章节', "KKStriveImg_readV_catalogue_Normal", context),
          buildBottomMenuItem(
              '亮度', "KKStriveImg_readV_catalogue_Normal", context),
          buildBottomMenuItem(
              '文字', "KKStriveImg_readV_catalogue_Normal", context),
        ],
      ),
    );
  }

  buildBottomMenuItem(String title, String image, BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      child: Column(
        children: [
          Container(
              width: (ScreenUtil.getInstance().screenWidth - 30) / 4,
              padding: EdgeInsets.symmetric(vertical: 5),
              child: LoadAssetImage(
                image,
                fit: BoxFit.contain,
                width: 35,
                height: 35,
              )),
          Text(
            title,
            style:
                TextStyle(fontSize: Dimensions.font_sp12, color: Colors.white),
          )
        ],
      ),
      onTap: () {
        if (title == "目录") {
          _logic.showMenu();
          _logic.showDirectory(context);
        }
        if (title == "章节") {}
        if (title == "亮度") {}
        if (title == "文字") {}
      },
    );
  }
}
