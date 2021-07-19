
import 'package:flutter/material.dart';
import 'package:flutter_dingdian/constant/colors.dart';
import 'package:flutter_dingdian/constant/dimensions.dart';
import 'package:flutter_dingdian/constant/gaps.dart';
import 'package:flutter_dingdian/moudules/tabbar/logic.dart';
import 'package:flutter_dingdian/utils/image/load_image.dart';
import 'package:get/get.dart';

class BookShelfEmptyWidget extends StatelessWidget {
  const BookShelfEmptyWidget({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          LoadAssetImage("comicIMG_17"),
          Gaps.hGap32,
          GestureDetector(
            onTap: () => Get.find<TabbarLogic>().pageController.jumpToPage(1),
                      child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: MyColors().getThemeColor(),
                borderRadius: BorderRadius.circular(25)
              ),
              height: 50,
              width: 200,
              child: Text("逛逛书城",style: 
              TextStyle(fontSize: Dimensions.font_sp18,color: Colors.white),),
            ),
          )
        ],
      ),
    );
  }
}