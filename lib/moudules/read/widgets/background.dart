import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dingdian/moudules/read/logic.dart';
import 'package:flutter_dingdian/utils/image/image_utils.dart';
import 'package:get/get.dart';

class ReadBottomBackgroundWidget extends StatelessWidget {
 final List themes = [
    "theme1_read_bg",
    "theme2_read_bg",
    "theme3_read_bg",
    "theme4_read_bg",
    "KKStriveImg_readV_backgroundImgX_Normal"
  ];
  final BookReadLogic _logic = Get.put(BookReadLogic());
  @override
  Widget build(BuildContext context) {
    return Container(
      child: GridView.builder(
        padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 5,
            mainAxisSpacing: 0,
            crossAxisSpacing: 30,
            childAspectRatio: 1),
        itemCount: themes.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              _logic.changeTheme(themes[index]);
            },
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: Border.all(
                    color: themes[index] == _logic.state.configModel!.theme ? Color.fromRGBO(0, 153, 255, 1) : Colors.transparent,
                    width:  1),
                image: DecorationImage(
                  image: ExactAssetImage(ImageUtils.getImgPath(themes[index])),
                  fit: BoxFit.fill,
                ),
                borderRadius: BorderRadius.circular(
                    (ScreenUtil.getInstance().screenWidth - 60 - 240) / 2),
              ),
            ),
          );
        },
      ),
    );
  }
}
