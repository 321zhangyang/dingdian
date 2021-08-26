import 'package:fijkplayer/fijkplayer.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dingdian/utils/image/load_image.dart';
import 'package:fun_flutter_kit/fun_flutter_kit.dart';
import 'package:get/get.dart';

import 'logic.dart';
import 'state.dart';

class LivePlayPage extends StatelessWidget {
  final LivePlayLogic logic = Get.put(LivePlayLogic());
  final LivePlayState state = Get.find<LivePlayLogic>().state;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FunStateObx(
            controller: logic,
            builder: () {
              return Stack(
                children: [
                  Container(
                    child: FijkView(
                      player: state.player,
                      fit: FijkFit.cover,
                      width: ScreenUtil.getInstance().screenWidth,
                      height: ScreenUtil.getInstance().screenHeight,
                    ),
                  ),
                  Positioned(
                      top: 44,
                      left: 10,
                      child: GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: Container(
                          height: 44,
                          width: 44,
                          child: LoadAssetImage("nav_back_Normal"),
                        ),
                      ))
                ],
              );
            }));
  }
}
