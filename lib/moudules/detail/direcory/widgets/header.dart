import 'package:flutter/material.dart';
import 'package:flutter_dingdian/constant/colors.dart';
import 'package:flutter_dingdian/constant/dimensions.dart';

class BookDirectoryHeaderWidget extends StatelessWidget {
  final String? name;

  const BookDirectoryHeaderWidget({Key? key, this.name}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(name!,style: TextStyle(fontSize: Dimensions.font_sp14,color: MyColors.text_gray_color),),
      height: 44,
      alignment: Alignment.centerLeft,
      
    );
  }
}
