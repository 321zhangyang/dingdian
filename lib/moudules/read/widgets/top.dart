import 'package:flustars/flustars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dingdian/moudules/read/logic.dart';
import 'package:flutter_dingdian/utils/image/load_image.dart';
import 'package:get/get.dart';

class ReadTopWidget extends StatelessWidget {
  final BookReadLogic _logic = Get.put(BookReadLogic());
  @override
  Widget build(BuildContext context) {
    return Container(
        height: ScreenUtil.getInstance().appBarHeight +
            ScreenUtil.getInstance().statusBarHeight,
        child: AppBar(
          backgroundColor: Color.fromRGBO(0, 0, 0, 1),
          actions: [
            GestureDetector(
              onTap: () async {
                _logic.showMenu();
                _showCupertinoActionSheet(context);
              },
              child: Container(
                alignment: Alignment.center,
                width: 50,
                height: 40,
                child: Text("下载"),
              ),
            )
          ],
          leading: GestureDetector(
            onTap: () async {
              if (await _logic
                      .exitsInBookShelfById(_logic.state.bookModel!.id!) ==
                  false) {
                _logic.confirmAddToShelf(context);
              } else {
                Get.back();
              }
            },
            child: Container(
              alignment: Alignment.center,
              child: LoadAssetImage("nav_back_Normal"),
            ),
          ),
        ));
  }

  _showCupertinoActionSheet(BuildContext context) async {
    var result = await showCupertinoModalPopup(
        context: context,
        builder: (context) {
          return CupertinoActionSheet(
            title: null,
            message: null,
            actions: <Widget>[
              CupertinoActionSheetAction(
                child: Text('从当前章节下载'),
                onPressed: () {
                  Navigator.of(context).pop('delete');
                  _logic.downloadContent(_logic.state.bookModel!.cChapter!);
                },
                isDefaultAction: true,
              ),
              CupertinoActionSheetAction(
                child: Text('全本下载'),
                onPressed: () {
                  Navigator.of(context).pop('not delete');
                  _logic.downloadContent(0);
                },
                isDefaultAction: true,
              ),
            ],
            cancelButton: CupertinoActionSheetAction(
              child: Text('取消'),
              onPressed: () {
                Navigator.of(context).pop('cancel');
              },
            ),
          );
        });
    print('$result');
  }
}
