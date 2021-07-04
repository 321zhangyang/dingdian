import 'package:flutter/material.dart';
import 'package:flutter_dingdian/constant/constants.dart';
import 'package:flutter_dingdian/moudules/shop/category/model/category_model.dart';
import 'package:flutter_dingdian/routes/app_routes.dart';
import 'package:flutter_dingdian/utils/image/load_image.dart';
import 'package:fun_flutter_kit/fun_flutter_kit.dart';
import 'package:get/get.dart';

import 'logic.dart';
import 'state.dart';

class ShopCategoryPage extends StatelessWidget {
  final ShopCategoryLogic _logic = Get.put(ShopCategoryLogic());
  final ShopCategoryState state = Get.find<ShopCategoryLogic>().state;

  @override
  Widget build(BuildContext context) {
    return FunStateObx(
      controller: _logic,
      builder: () => Container(
        color: Colors.white,
        child: GridView.builder(
          padding: EdgeInsets.fromLTRB(15, 15, 15, 0),
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 15,
              crossAxisSpacing: 20,
              childAspectRatio: 0.75),
          itemCount: _logic.state.categorys.length,
          itemBuilder: (context, index) {
            BookCategoryModel model = _logic.state.categorys[index];
            return GestureDetector(
                onTap: () {
                  Get.toNamed(Routes.CATEGORYLIST, arguments: {"model": model});
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(240, 240, 240, 1),
                      borderRadius: BorderRadius.circular(8)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        child: LoadAssetImage(
                          model.image ?? "",
                          width: 100,
                          height: 100,
                          fit: BoxFit.contain,
                        ),
                      ),
                      Text(
                        model.name ?? "",
                        style: TextStyle(fontSize: Dimensions.font_sp16),
                        maxLines: 1,
                      ),
                      Gaps.vGap8,
                      Text(
                        model.total.toString(),
                        style: TextStyle(
                            fontSize: Dimensions.font_sp14,
                            color: MyColors.text_gray_color),
                        maxLines: 1,
                      ),
                    ],
                  ),
                ));
          },
        ),
      ),
    );
  }
}
