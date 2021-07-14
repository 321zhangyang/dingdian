import 'package:flutter/material.dart';
import 'package:flutter_dingdian/constant/colors.dart';
import 'package:flutter_dingdian/constant/dimensions.dart';
import 'package:flutter_dingdian/constant/gaps.dart';
import 'package:flutter_dingdian/moudules/read/logic.dart';
import 'package:flutter_dingdian/utils/image/load_image.dart';
import 'package:get/get.dart';

class ReadDirectoryWidget extends StatelessWidget {
  final BookReadLogic _logic = Get.put(BookReadLogic());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            _logic.state.chapterModel!.name ?? "",
            style: TextStyle(fontSize: Dimensions.font_sp18,color: MyColors.text_color),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          leadingWidth: 50,
          actions: [
            GestureDetector(
              onTap: () {
                _logic.sortTheDirectory();
              },
              child: Container(
                width: 50,
                height: 30,
                alignment: Alignment.center,
                child: LoadAssetImage(_logic.state.positive == true
                        ? "KKStriveImg_readV_categoryDESC_Normal"
                        : "KKStriveImg_readV_categoryASC_Normal",width: 30,height: 30,),
              ),
            ),
          ],
        ),
        body: SafeArea(
          child: Container(
            color: Colors.white,
            child: ListView.builder(
              padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
              itemBuilder: (context, index) =>
                  _logic.state.groupHandler!.cellAtIndex(index),
              itemCount: _logic.state.groupHandler!.allItemCount,
            ),
          ),
        ));
  }
}
