import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dingdian/constant/colors.dart';
import 'package:flutter_dingdian/constant/dimensions.dart';
import 'package:flutter_dingdian/constant/gaps.dart';
import 'package:flutter_dingdian/moudules/shop/list/detail/widgets/item.dart';
import 'package:flutter_dingdian/moudules/shop/list/model/detail_model.dart';
import 'package:flutter_dingdian/utils/image/image_utils.dart';
import 'package:flutter_dingdian/utils/image/load_image.dart';
import 'package:fun_flutter_kit/fun_flutter_kit.dart';
import 'package:get/get.dart';

import 'logic.dart';
import 'state.dart';

class ShopBookListDetailPage extends StatelessWidget {
  final ShopBookListDetailLogic _logic = Get.put(ShopBookListDetailLogic());
  final ShopBookListDetailState state =
      Get.find<ShopBookListDetailLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("书单详情"),
      ),
      body: Container(
        child: FunStateObx(
          controller: _logic,
          builder: () => SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.fromLTRB(15, 15, 15, 15),
                  color: Colors.white,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      LoadImage(
                        ImageUtils.getNetWorkPath(
                            _logic.state.model?.cover ?? ""),
                        holderImg: "app_placeholder",
                        width: 100,
                        height: 100 * 1.35,
                      ),
                      Gaps.hGap15,
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Gaps.vGap10,
                            Text(_logic.state.model?.title ?? "",
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: Dimensions.font_sp16,
                                    color: MyColors.text_color)),
                            Gaps.vGap10,
                            Text(
                              "共 ${_logic.state.model?.bookList?.length} 本",
                              style: TextStyle(
                                  fontSize: Dimensions.font_sp14,
                                  color: MyColors.text_gray_color),
                            ),
                            Gaps.vGap10,
                            Text(
                              _logic.state.model?.addTime ?? "",
                              style: TextStyle(
                                  fontSize: Dimensions.font_sp12,
                                  color: MyColors.text_gray_color),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Gaps.vGap10,
                Container(
                  padding: EdgeInsets.fromLTRB(15, 15, 15, 15),
                  color: Colors.white,
                  width: ScreenUtil.getInstance().screenWidth,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "简介",
                        style: TextStyle(
                            fontSize: Dimensions.font_sp16,
                            color: MyColors.text_color),
                      ),
                      Gaps.vGap10,
                      Text(
                        _logic.state.model?.description ?? "",
                        style: TextStyle(
                            fontSize: Dimensions.font_sp14,
                            color: MyColors.text_gray_color),
                      )
                    ],
                  ),
                ),
                Gaps.vGap10,
                Container(
                  padding: EdgeInsets.only(left: 15),
                  color: Colors.white,
                  height: 30,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "好书奉送",
                    style: TextStyle(
                        fontSize: Dimensions.font_sp16,
                        color: MyColors.text_color),
                  ),
                ),
                Container(
                  color: Colors.white,
                  child: ListView.separated(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        BookList model = _logic.state.model!.bookList![index];
                        return ShopBookListDetailItem(
                          model: model,
                        );
                      },
                      separatorBuilder: (context, index) {
                        return Divider(
                          indent: 15,
                        );
                      },
                      itemCount: _logic.state.model!.bookList!.length),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
