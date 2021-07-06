import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'logic.dart';
import 'state.dart';

class BookSearchPage extends StatelessWidget {
  final BookSearchLogic logic = Get.put(BookSearchLogic());
  final BookSearchState state = Get.find<BookSearchLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
