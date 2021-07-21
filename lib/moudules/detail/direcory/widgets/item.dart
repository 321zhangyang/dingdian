import 'package:flutter/material.dart';
import 'package:flutter_dingdian/constant/constants.dart';
import 'package:flutter_dingdian/constant/dimensions.dart';
import 'package:flutter_dingdian/moudules/detail/model/directory_model.dart';

class BookDirectoryItemWidget extends StatelessWidget {
  final TwoList? item;
  final bool? select;
  final bool? isDownload;
  const BookDirectoryItemWidget({Key? key, this.item, this.select, this.isDownload})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 220,
          child: Text(
            item!.name ?? "",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                fontSize: Dimensions.font_sp16,
                color: select == false
                    ? MyColors.text_color
                    : Color.fromRGBO(214, 61, 73, 1)),
          ),
          height: 50,
          alignment: Alignment.centerLeft,
        ),
        Expanded(child: Text("")),
       isDownload == true ? Container(child: Text("已缓存")) : Container()
      ],
    );
  }
}
