import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'logic.dart';
import 'state.dart';

class ShopBookListDetailPage extends StatelessWidget {
  final ShopBookListDetailLogic logic = Get.put(ShopBookListDetailLogic());
  final ShopBookListDetailState state = Get.find<ShopBookListDetailLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
