import 'package:flutter/material.dart';
import 'package:flutter_dingdian/moudules/shop/choose/list/widgets/item.dart';
import 'package:flutter_dingdian/moudules/shop/choose/model/list_model.dart';
import 'package:fun_flutter_kit/state/src/controller/fun_state_obx.dart';
import 'package:get/get.dart';

import 'logic.dart';
import 'state.dart';

class ShopChooseMorePage extends StatelessWidget {
  final ShopChooseMoreLogic _logic = Get.put(ShopChooseMoreLogic());
  final ShopChooseMoreState state = Get.find<ShopChooseMoreLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text(Get.arguments["title"]),
        ),
        body: FunStateRefresherObx(
          builder: () => ListView.separated(
              itemBuilder: (context, index) {
                BookList model = _logic.list[index];
                return ShopChooseListItem(
                  model: model,
                );
              },
              separatorBuilder: (context, index) {
                return Divider(
                  height: 1.0,
                  indent: 30.0,
                  color: Color.fromRGBO(240, 240, 240, 1),
                );
              },
              shrinkWrap: true,
              itemCount: _logic.list.length),
          controller: _logic,
          enablePullUp: true,
        ));
  }
}
