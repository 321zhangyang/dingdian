import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_dingdian/moudules/read/logic.dart';
import 'package:flutter_dingdian/moudules/read/model/font_model.dart';
import 'package:flutter_dingdian/utils/cache/cache_util.dart';
import 'package:flutter_dingdian/utils/toast/toast.dart';
import 'package:get/get.dart';

class ReadFontFamilyPage extends StatefulWidget {
  @override
  _ReadFontFamilyPageState createState() => _ReadFontFamilyPageState();
}

class _ReadFontFamilyPageState extends State<ReadFontFamilyPage> {
  final _logic = Get.find<BookReadLogic>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("字体"),
      ),
      body: ListView.separated(
          itemBuilder: (context, index) {
            FontInfoModel model = _logic.state.fontList![index];
            return Container(
              padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
              height: 50,
              child: Row(
                children: [
                  Text(model.key == "Roboto" ? model.value : model.key),
                  Spacer(),
                  GestureDetector(
                    onTap: () async {
                      //下载
                      if (model.fileInfo == null && model.key != "Roboto") {
                        Toast.showLoadingText("下载中");
                        try {
                          await _logic.saveFontFamily(model.value, model.key);
                          Toast.dismiss();
                        } catch (e) {
                          Toast.showError("下载失败");
                        }
                      } else {
                        _logic.changeFontFamily(model.key);
                      }
                      setState(() {});
                    },
                    child: Container(
                      width: 50,
                      height: 30,
                      alignment: Alignment.center,
                      child: _logic.state.configModel!.fontFamily == model.key
                          ? Icon(Icons.check)
                          : Text(
                              (model.fileInfo != null || model.key == "Roboto")
                                  ? "使用"
                                  : "下载"),
                    ),
                  )
                ],
              ),
            );
          },
          separatorBuilder: (context, index) {
            return Divider(
              indent: 15,
              height: 1,
            );
          },
          itemCount: _logic.state.fontList!.length),
    );
  }
}
