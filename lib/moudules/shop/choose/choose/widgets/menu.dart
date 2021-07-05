import 'package:flutter/material.dart';
import 'package:flutter_dingdian/constant/gaps.dart';
import 'package:flutter_dingdian/moudules/shop/choose/choose/logic.dart';
import 'package:flutter_dingdian/utils/image/load_image.dart';
import 'package:get/get.dart';

class ShopChooseMenuWidget extends StatelessWidget {
  final List<String> titles = ["推荐", "收藏", "评分", "完结", "热更"];
  final List<String> images = [
    "KKStriveImg_shop_tj_Normal",
    "KKStriveImg_shop_sc_Normal",
    "KKStriveImg_shop_pf_Normal",
    "KKStriveImg_shop_wj_Normal",
    "KKStriveImg_shop_rg_Normal"
  ];
  final _logic = Get.find<ShopChooseLogic>();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: GridView.builder(
        padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: titles.length,
            mainAxisSpacing: 0,
            crossAxisSpacing: 20,
            childAspectRatio: 0.85),
        itemCount: titles.length,
        itemBuilder: (context, index) {
          return GestureDetector(
              onTap: () {
                _logic.jumpToList(index,titles[index]);
              },
              child: Column(
                children: [
                  LoadAssetImage(images[index]),
                  Gaps.vGap4,
                  Text(titles[index])
                ],
              ));
        },
      ),
    );
  }
}
