import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dingdian/constant/constants.dart';
import 'package:flutter_dingdian/constant/dimensions.dart';
import 'package:flutter_dingdian/moudules/read/logic.dart';
import 'package:flutter_dingdian/routes/app_routes.dart';
import 'package:flutter_dingdian/utils/image/load_image.dart';
import 'package:get/get.dart';

class ReadBottomFontWidget extends StatelessWidget {
  final BookReadLogic _logic = Get.put(BookReadLogic());
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
          child: Row(
            children: [
              Container(
                alignment: Alignment.center,
                width: (ScreenUtil.getInstance().screenWidth - 50) / 2,
                height: 45,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.white, width: 1.5),
                    borderRadius: BorderRadius.circular(5)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          _logic.changeFont(true);
                        },
                        child: Container(
                          child: LoadAssetImage(
                              "KKStriveImg_readV_fontDecrese_Normal"),
                        ),
                      ),
                    ),
                    Container(
                        decoration: BoxDecoration(
                            border: Border(
                          left: BorderSide(color: Colors.white, width: 1.5),
                          right: BorderSide(color: Colors.white, width: 1.5),
                        )),
                        width: (ScreenUtil.getInstance().screenWidth - 50) / 6,
                        alignment: Alignment.center,
                        child: Text(
                          _logic.state.configModel!.font.toString(),
                          style: TextStyle(
                              fontSize: Dimensions.font_sp15,
                              color: Colors.white),
                        )),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          _logic.changeFont(false);
                        },
                        child: Container(
                          child: LoadAssetImage(
                              "KKStriveImg_readV_fontIncrease_Normal"),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Gaps.hGap20,
              Container(
                alignment: Alignment.center,
                width: (ScreenUtil.getInstance().screenWidth - 50) / 2,
                height: 45,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.white, width: 1.5),
                    borderRadius: BorderRadius.circular(5)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          _logic.changeHeight(true);
                        },
                        child: Container(
                          child: LoadAssetImage(
                              "KKStriveImg_readV_gapDecrese_Normal"),
                        ),
                      ),
                    ),
                    Container(
                        decoration: BoxDecoration(
                            border: Border(
                          left: BorderSide(color: Colors.white, width: 1.5),
                          right: BorderSide(color: Colors.white, width: 1.5),
                        )),
                        width: (ScreenUtil.getInstance().screenWidth - 50) / 6,
                        alignment: Alignment.center,
                        child: Text(
                          _logic.state.configModel!.height!.toStringAsFixed(1),
                          style: TextStyle(
                              fontSize: Dimensions.font_sp15,
                              color: Colors.white),
                        )),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          _logic.changeHeight(false);
                        },
                        child: Container(
                          child: LoadAssetImage(
                              "KKStriveImg_readV_gapIncrease_Normal"),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        GestureDetector(
          onTap: () {
            Get.toNamed(Routes.FONT);
          },
          child: Container(
            alignment: Alignment.centerLeft,
            height: 40,
            width: 40,
            child: Text(
              "字体",
              style:
                  TextStyle(fontSize: Dimensions.font_sp16, color: Colors.blue),
            ),
          ),
        )
      ],
    );
  }
}
