import 'dart:ffi';

import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dingdian/constant/dimensions.dart';
import 'package:flutter_dingdian/moudules/shop/list/model/list_model.dart';
import 'package:flutter_dingdian/utils/image/image_utils.dart';
import 'package:flutter_dingdian/utils/image/load_image.dart';

class ShopBookListCommendItem extends StatelessWidget {
  final ShopBookListModel? model;

  const ShopBookListCommendItem({Key? key, this.model}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(15, 15, 15, 15),
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                height: 140,
                width: ScreenUtil.getInstance().screenWidth - 30,
                child: LoadImage(
                  ImageUtils.getNetWorkPath(model?.commendImage ?? ""),
                  holderImg: "bookdan_icondefault_Normal",
                  fit: BoxFit.fill,
                ),
              ),
              Positioned(
                  bottom: 0,
                  child: Container(
                    width: ScreenUtil.getInstance().screenWidth - 30,
                    padding: EdgeInsets.only(left: 10),
                    height: 40,
                    alignment: Alignment.centerLeft,
                    color: Color.fromRGBO(0, 0, 0, 0.3),
                    child: Text(model?.title ?? "",style: TextStyle(fontSize: Dimensions.font_sp14,color: Colors.white),),
                  ))
            ],
          )
        ],
      ),
    );
  }
}
