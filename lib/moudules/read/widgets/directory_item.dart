
import 'package:flutter/material.dart';
import 'package:flutter_dingdian/constant/colors.dart';
import 'package:flutter_dingdian/constant/dimensions.dart';
import 'package:flutter_dingdian/moudules/detail/model/directory_model.dart';

class ReadDirectoryItemWidget extends StatelessWidget {
  final TwoList? item;

  const ReadDirectoryItemWidget({Key? key, this.item}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        item!.name ?? "",
        style: TextStyle(
            fontSize: Dimensions.font_sp16, color: MyColors.text_color),
      ),
      height: 50,
      alignment: Alignment.centerLeft,
    );
  }
}