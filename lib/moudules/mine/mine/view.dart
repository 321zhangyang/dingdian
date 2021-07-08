import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dingdian/constant/dimensions.dart';
import 'package:flutter_dingdian/constant/gaps.dart';
import 'package:flutter_dingdian/routes/app_routes.dart';
import 'package:flutter_dingdian/utils/image/load_image.dart';
import 'package:fun_flutter_kit/fun_flutter_kit.dart';
import 'package:get/get.dart';

import 'logic.dart';
import 'state.dart';

class MinePage extends StatelessWidget {
  final MineLogic _logic = Get.put(MineLogic());
  final MineState state = Get.find<MineLogic>().state;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: FunStateObx(
        controller: _logic,
        builder: () {
          return Container(
            color: Colors.white,
            child: Column(
              children: [
                SizedBox(
                  height: ScreenUtil.getInstance().appBarHeight,
                ),
                GestureDetector(
                  onTap: () {
                    print("登录");
                  },
                  child: Container(
                    width: ScreenUtil.getInstance().screenWidth,
                    child: Column(
                      children: [
                        LoadAssetImage(
                          "KKStriveImg_setV_boyHead_Normal",
                          width: 80,
                          height: 80,
                        ),
                        Gaps.vGap10,
                        Text(
                          "立即登录发现新世界",
                          style: TextStyle(fontSize: Dimensions.font_sp16),
                        )
                      ],
                    ),
                  ),
                ),
                Gaps.vGap50,
                Container(
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(240, 240, 240, 1),
                      border: Border(
                        top: BorderSide(
                            width: 1, color: Color.fromRGBO(240, 240, 240, 1)),
                        bottom: BorderSide(
                            width: 1, color: Color.fromRGBO(240, 240, 240, 1)),
                      )),
                  child: GridView.builder(
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        mainAxisSpacing: 1,
                        crossAxisSpacing: 1,
                        childAspectRatio: 1.3),
                    itemCount: _logic.state.titles.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                          onTap: () {
                             if (index == 2) {
                              Get.toNamed(Routes.READHISTORY);
                            }
                            if (index == 7) {
                              Get.toNamed(Routes.THEME);
                            }
                          },
                          child: Container(
                            alignment: Alignment.center,
                            color: Colors.white,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                LoadAssetImage(_logic.state.images[index]),
                                Gaps.vGap10,
                                Text(
                                  _logic.state.titles[index],
                                  style:
                                      TextStyle(fontSize: Dimensions.font_sp16),
                                  maxLines: 1,
                                ),
                              ],
                            ),
                          ));
                    },
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
