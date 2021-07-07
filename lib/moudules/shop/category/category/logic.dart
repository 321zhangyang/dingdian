import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_dingdian/moudules/shop/category/model/category_model.dart';
import 'package:fun_flutter_kit/state/src/controller/fun_state_action_controller.dart';
import 'state.dart';

class ShopCategoryLogic extends FunStateActionController {
  final state = ShopCategoryState();

  @override
  void onInit() {
    super.onInit();

    loadData();
  }

  @override
  Future onLoadData() async {
    String jsonString = await rootBundle.loadString("assets/json/category.json");
    final jsonResult = json.decode(jsonString);
    for (Map<String, dynamic> map in jsonResult) {
      state.categorys.add(BookCategoryModel.fromJson(map));
    }
  }
}
