
import 'package:flutter/material.dart';
import 'package:flutter_dingdian/constant/gaps.dart';
import 'package:flutter_dingdian/utils/image/load_image.dart';

class CommonEmptyWidget extends StatelessWidget {
  const CommonEmptyWidget({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          LoadAssetImage("yd_error_Normal"),
          Gaps.vGap32,
          Text("还没有内容哦~")
        ],
      ),
    );
  }
}