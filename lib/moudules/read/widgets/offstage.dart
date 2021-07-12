import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dingdian/moudules/read/logic.dart';
import 'package:flutter_dingdian/moudules/read/widgets/bottom.dart';
import 'package:flutter_dingdian/moudules/read/widgets/top.dart';
import 'package:get/get.dart';

class ReadOffstageWidget extends StatelessWidget {
  final BookReadLogic _logic = Get.put(BookReadLogic());
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          child: Column(
            children: [
              ReadTopWidget(),
              midTransparent(),
              ReadBottomWidget(),
            ],
          ),
        )
      ],
    );
  }

  Widget midTransparent() {
    return Expanded(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        child: Container(
          color: Colors.transparent,
          width: double.infinity,
          height: ScreenUtil.getInstance().screenHeight,
        ),
        onTap: () {
          _logic.showMenu();
        },
      ),
    );
  }
}
