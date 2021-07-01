import 'package:flutter/material.dart';
import 'package:flutter_dingdian/constant/constants.dart';
import 'package:flutter_dingdian/moudules/shop/choose/choose/logic.dart';
import 'package:flutter_dingdian/moudules/shop/choose/model/banner_model.dart';
import 'package:flutter_dingdian/utils/image/load_image.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:get/get.dart';

class ShopChoseBannerWidget extends StatelessWidget {
  final _logic = Get.find<ShopChooseLogic>();
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: Colors.transparent,
        ),
        height: 150,
        child: Swiper(
          itemCount: _logic.state.banner!.length,
          autoplay: true,
          itemBuilder: (BuildContext context, int index) {
            BookBannerModel model = _logic.state.banner![index];
            // 获取图片
            return Card(
              color: Colors.transparent,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusDirectional.circular(10)),
              clipBehavior: Clip.antiAlias,
              child: LoadImage(
                  model.imgurl,
                  fit: BoxFit.fill),
            );
          },
          // 添加一个页码指示器
          pagination: SwiperPagination(
              alignment: Alignment.bottomCenter, //将小圆点放置到图片左下角
              builder: DotSwiperPaginationBuilder(
                color: Color.fromRGBO(255, 255, 255, 0.85), // 其他点的颜色
                activeColor: MyColors().getThemeColor(), // 当前点的颜色
                activeSize: 8,
                size: 8,
                space: 4, // 点与点之间的距离
              )),
        ));
  }
}
