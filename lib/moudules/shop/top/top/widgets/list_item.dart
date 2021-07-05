import 'package:flutter/material.dart';
import 'package:flutter_dingdian/moudules/shop/choose/list/widgets/item.dart';
import 'package:flutter_dingdian/moudules/shop/choose/model/list_model.dart';
import 'package:flutter_dingdian/utils/image/load_image.dart';

class ShopTopListItem extends StatelessWidget {
  final int? index;
  final BookList? model;
  static const List images = [
    "KKStriveImg_rankV_gold_Normal",
    "KKStriveImg_rankV_silver_Normal",
    "KKStriveImg_rankV_cuprum_Normal"
  ];

  const ShopTopListItem({Key? key, this.index, this.model}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          ShopChooseListItem(model: model,),
          index! < 3
              ? Positioned(
                  top: 15,
                  right: 15,
                  child: LoadAssetImage(
                    images[index!],
                    width: 40,
                    height: 40,
                    fit: BoxFit.fill,
                  ))
              : Container()
        ],
      ),
    );
  }
}
