import 'package:flutter/material.dart';
import 'package:flutter_dingdian/utils/image/load_image.dart';
import 'package:fun_flutter_kit/fun_flutter_kit.dart';
import 'package:get/get.dart';
import 'package:list_group_handler/list_group_handler.dart';

import 'logic.dart';
import 'state.dart';

class BookDetailDirectoryPage extends StatefulWidget {
  @override
  _BookDetailDirectoryPageState createState() =>
      _BookDetailDirectoryPageState();
}

class _BookDetailDirectoryPageState extends State<BookDetailDirectoryPage> {
  final BookDetailDirectoryLogic _logic = Get.put(BookDetailDirectoryLogic());

  final BookDetailDirectoryState state =
      Get.find<BookDetailDirectoryLogic>().state;

  @override
  Widget build(BuildContext context) {
    return FunStateObx(
      controller: _logic,
      builder: () {
        return Scaffold(
            appBar: AppBar(
              title: Text(Get.arguments["title"]),
              actions: [
                GestureDetector(
                  onTap: () {
                    _logic.sortTheDirectory();
                  },
                  child: Container(
                    child: LoadAssetImage(_logic.state.positive == true
                        ? "KKStriveImg_readV_categoryDESC_Normal"
                        : "KKStriveImg_readV_categoryASC_Normal"),
                  ),
                )
              ],
            ),
            body: SafeArea(
              child: ListView.builder(
                padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                itemBuilder: (context, index) =>
                    _logic.state.groupHandler!.cellAtIndex(index),
                itemCount: _logic.state.groupHandler!.allItemCount,
              ),
            ));
      },
    );
  }
}
