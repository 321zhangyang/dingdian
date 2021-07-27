import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dingdian/constant/dimensions.dart';
import 'package:flutter_dingdian/constant/gaps.dart';
import 'package:flutter_dingdian/moudules/read/api/repository.dart';
import 'package:flutter_dingdian/moudules/read/logic.dart';
import 'package:flutter_dingdian/moudules/read/widgets/background.dart';
import 'package:flutter_dingdian/moudules/read/widgets/font.dart';
import 'package:flutter_dingdian/moudules/read/widgets/slider.dart';
import 'package:flutter_dingdian/moudules/read/widgets/turn.dart';
import 'package:flutter_dingdian/utils/image/load_image.dart';
import 'package:get/get.dart';

enum Type { BACKGROUND, FONT, FLIOVER, SLIDER }

class ReadBottomMenuWidget extends StatefulWidget {
  @override
  _ReadBottomMenuWidgetState createState() => _ReadBottomMenuWidgetState();
}

class _ReadBottomMenuWidgetState extends State<ReadBottomMenuWidget> {
  Type type = Type.SLIDER;
  final BookReadLogic _logic = Get.put(BookReadLogic());
 
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [buildHeader(), Gaps.vGap10, buildFooter()],
      ),
    );
  }

  Widget buildHeader() {
    switch (type) {
      case Type.BACKGROUND:
        return ReadBottomBackgroundWidget();
      case Type.FONT:
        return ReadBottomFontWidget();
      case Type.FLIOVER:
        return ReadBottomTurnWidget();
      case Type.SLIDER:
        return ReadBottomSliderWidget();
      default:
        return Container();
    }
  }

  Widget buildFooter() {
    return Container(
      height: ScreenUtil.getInstance().bottomBarHeight + 50,
      width: ScreenUtil.getInstance().screenWidth,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          buildBottomMenuItem(
              '目录', "KKStriveImg_readV_catalogue_Normal", context),
          buildBottomMenuItem(
              '文字', "KKStriveImg_readV_fontBtn_Normal", context),
          buildBottomMenuItem(
              '背景', "KKStriveImg_readV_setting_Normal", context),
          buildBottomMenuItem(
              '翻页', "KKStriveImg_readV_ pagingBtn_Normal", context),
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
                color: Colors.white,
              )),
          Text(
            title,
            style:
                TextStyle(fontSize: Dimensions.font_sp12, color: Colors.white),
          )
        ],
      ),
      onTap: () async {
        if (title == "目录") {
          _logic.showMenu();
          _logic.showDirectory(context);
          type = Type.SLIDER;
        }
        if (title == "文字") {
          setState(() {
            if (type == Type.FONT) {
              type = Type.SLIDER;
            } else {
              type = Type.FONT;
            }
          });
        }
        if (title == "背景") {
        

          setState(() {
            if (type == Type.BACKGROUND) {
              type = Type.SLIDER;
            } else {
              type = Type.BACKGROUND;
            }
          });
        }
        if (title == "翻页") {
          setState(() {
            if (type == Type.FLIOVER) {
              type = Type.SLIDER;
            } else {
              type = Type.FLIOVER;
            }
          });
        }
      },
    );
  }
}
