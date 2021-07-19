import 'package:flutter/material.dart';
import 'package:flutter_dingdian/constant/constants.dart';
import 'package:flutter_dingdian/utils/image/load_image.dart';

class CommonErrorWidget extends StatelessWidget {
  final Function? click;
  const CommonErrorWidget({Key? key, this.click}) : super(key: key);

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
          Text("获取内容出错了,请重试"),
          Gaps.vGap20,
          GestureDetector(
            onTap: () {
              click!();
            },
            child: Container(
              alignment: Alignment.center,
              width: 100,
              height: 40,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: MyColors.text_gray_color)),
              child: Text(
                "点击重试",
                style: TextStyle(
                    fontSize: Dimensions.font_sp16,
                    color: MyColors.text_gray_color),
              ),
            ),
          )
        ],
      ),
    );
  }
}
