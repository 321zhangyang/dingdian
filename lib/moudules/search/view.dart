import 'package:flutter/material.dart';
import 'package:flutter_dingdian/local/local_search_history_repository.dart';
import 'package:flutter_dingdian/moudules/search/widgets/history_widget.dart';
import 'package:flutter_dingdian/moudules/search/widgets/list.dart';
import 'package:flutter_dingdian/moudules/search/widgets/search_bar.dart';
import 'package:get/get.dart';

import 'logic.dart';
import 'state.dart';

class BookSearchPage extends StatelessWidget {
  final BookSearchLogic logic = Get.put(BookSearchLogic());
  final BookSearchState state = Get.find<BookSearchLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leadingWidth: 0,
        leading: Container(),
        title: SearchBar(
          onPressed: (value) {
            print(value);
            SearchHistoryRepository.saveHistory(value);
          },
          onClose: () {
            print(SearchHistoryRepository.getHistory());
          },
          back: () {
            Get.back();
          },
        ),
      ),
      body: Container(alignment: Alignment.topCenter,child: SearchHistoryWidget()),
    );
  }
}
