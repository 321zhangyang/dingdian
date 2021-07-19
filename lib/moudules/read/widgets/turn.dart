import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dingdian/constant/constants.dart';
import 'package:flutter_dingdian/moudules/read/logic.dart';
import 'package:get/get.dart';

class ReadBottomTurnWidget extends StatefulWidget {
  const ReadBottomTurnWidget({Key? key}) : super(key: key);

  @override
  _ReadBottomTurnWidgetState createState() => _ReadBottomTurnWidgetState();
}

class _ReadBottomTurnWidgetState extends State<ReadBottomTurnWidget> {
  final BookReadLogic _logic = Get.put(BookReadLogic());
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
      height: 50,
      width: ScreenUtil.getInstance().screenWidth,
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              _logic.changeTurnType(0);
            },
            child: Container(
              width: 60,
              height: 40,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: Border.all(
                    color: _logic.state.configModel!.turnType == 0
                        ? MyColors().getThemeColor()
                        : Colors.white,
                    width: 1),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Text(
                "无",
                style: TextStyle(
                    fontSize: Dimensions.font_sp14, color: Colors.white),
              ),
            ),
          ),
          Gaps.hGap20,
          GestureDetector(
            onTap: () {
              _logic.changeTurnType(1);
            },
            child: Container(
              width: 60,
              height: 40,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: Border.all(
                    color: _logic.state.configModel!.turnType == 1
                        ? MyColors().getThemeColor()
                        : Colors.white,
                    width: 1),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Text(
                "覆盖",
                style: TextStyle(
                    fontSize: Dimensions.font_sp14, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
