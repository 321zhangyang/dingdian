import 'package:flutter/material.dart';
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

  late ListViewGroupHandler _groupHandler;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: FunStateObx(
            controller: _logic,
            builder: () {
              return ListView.builder(
                itemBuilder: (context, index) =>
                    _groupHandler.cellAtIndex(index),
                itemCount: _groupHandler.allItemCount,
              );
            }));
  }
}
