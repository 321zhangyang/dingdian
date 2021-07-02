import 'package:flutter/material.dart';
import 'package:flutter_dingdian/moudules/shop/choose/choose/widgets/banner.dart';
import 'package:flutter_dingdian/moudules/shop/choose/choose/widgets/item.dart';
import 'package:flutter_dingdian/moudules/shop/choose/choose/widgets/menu.dart';
import 'package:flutter_dingdian/moudules/shop/choose/model/choose_model.dart';
import 'package:fun_flutter_kit/state/fun_state.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'logic.dart';
import 'state.dart';

class ShopChoosePage extends StatelessWidget {
  final ShopChooseLogic logic = Get.put(ShopChooseLogic());
  final ShopChooseState state = Get.find<ShopChooseLogic>().state;

  @override
  Widget build(BuildContext context) {
    return FunStateObx(
      controller: logic,
      onLoading: const Center(child: CircularProgressIndicator()),
      onError: (error) => Container(
        child: Text("出错了"),
      ),
      builder: () {
        return SmartRefresher(
          enablePullDown: true,
          enablePullUp: false,
          controller: logic.refreshController,
          onRefresh: () => logic.getdata(),
          child: ListView.separated(
            separatorBuilder: (context, index) {
              return Container(
                  height: 5, color: Color.fromRGBO(240, 240, 240, 1));
            },
            itemBuilder: (context, index) {
              if (index == 0) {
                return Padding(
                  padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
                  child: Column(
                    children: [ShopChoseBannerWidget(), ShopChooseMenuWidget()],
                  ),
                );
              } else {
                BookChooseModel model = logic.state.choose![index - 1];
                return ShopChooseItem(model: model,);
              }
            },
            itemCount: logic.state.choose!.length + 1,
          ),
        );
      },
    );
  }
}
