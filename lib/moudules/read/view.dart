import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'logic.dart';
import 'state.dart';

class BookReadPage extends StatelessWidget {
  final BookReadLogic logic = Get.put(BookReadLogic());
  final BookReadState state = Get.find<BookReadLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
