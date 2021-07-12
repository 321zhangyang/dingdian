import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dingdian/utils/image/load_image.dart';
import 'package:get/get.dart';

class ReadTopWidget extends StatelessWidget {
  const ReadTopWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: ScreenUtil.getInstance().appBarHeight +
            ScreenUtil.getInstance().statusBarHeight,
        child: AppBar(
          backgroundColor: Color.fromRGBO(0, 0, 0, 1),
          leading: GestureDetector(
            onTap: () => Get.back(),
                      child: Container(
              alignment: Alignment.center,
              child: LoadAssetImage("nav_back_Normal"),
            ),
          ),
        ));
  }
}
