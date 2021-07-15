import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dingdian/moudules/read/logic.dart';
import 'package:flutter_dingdian/utils/image/load_image.dart';
import 'package:get/get.dart';

class ReadTopWidget extends StatelessWidget {
  final BookReadLogic _logic = Get.put(BookReadLogic());
  @override
  Widget build(BuildContext context) {
    return Container(
        height: ScreenUtil.getInstance().appBarHeight +
            ScreenUtil.getInstance().statusBarHeight,
        child: AppBar(
          backgroundColor: Color.fromRGBO(0, 0, 0, 1),
          leading: GestureDetector(
            onTap: () async {
              if (await _logic
                      .exitsInBookShelfById(_logic.state.bookModel!.id!) ==
                  false) {
                _logic.confirmAddToShelf(context);
              } else {
                Get.back();
              }
            },
            child: Container(
              alignment: Alignment.center,
              child: LoadAssetImage("nav_back_Normal"),
            ),
          ),
        ));
  }
}
