import 'package:flutter/material.dart';
import 'package:flutter_dingdian/moudules/search/widgets/history_widget.dart';
import 'package:flutter_dingdian/moudules/search/widgets/list.dart';
import 'package:flutter_dingdian/moudules/search/widgets/search_bar.dart';
import 'package:fun_flutter_kit/fun_flutter_kit.dart';
import 'package:get/get.dart';

import 'logic.dart';
import 'state.dart';

class BookSearchPage extends StatelessWidget {
  final BookSearchLogic _logic = Get.put(BookSearchLogic());
  final BookSearchState state = Get.find<BookSearchLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leadingWidth: 0,
          elevation: 0,
          leading: Container(),
          title: SearchBar(
            onPressed: (value) {
              _logic.search(value);
            },
            onClose: () {
              _logic.reset();
            },
            back: () {
              Get.back();
            },
            controller: state.controller,
          ),
        ),
        body: FunStateObx(
          controller: _logic,
          builder: () {
            return _logic.state.isSearch == false
                ? SearchHistoryWidget()
                : BookSearchResultListWidget();
          },
        )
        // body: Container(
        //alignment: Alignment.topCenter, child: SearchHistoryWidget()),
        );
  }
}
