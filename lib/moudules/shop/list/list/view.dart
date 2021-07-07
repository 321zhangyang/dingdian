import 'package:flutter/material.dart';
import 'package:flutter_dingdian/constant/constants.dart';
import 'package:flutter_dingdian/moudules/shop/list/list/widgets/commend_item.dart';
import 'package:flutter_dingdian/moudules/shop/list/list/widgets/item.dart';
import 'package:flutter_dingdian/moudules/shop/list/model/list_model.dart';
import 'package:fun_flutter_kit/state/src/controller/fun_state_obx.dart';
import 'package:get/get.dart';

import 'logic.dart';
import 'state.dart';

class ShopBookListPage extends StatefulWidget {
  @override
  _ShopBookListPageState createState() => _ShopBookListPageState();
}

class _ShopBookListPageState extends State<ShopBookListPage>
    with TickerProviderStateMixin {
  final ShopBookListLogic _logic = Get.put(ShopBookListLogic());

  final ShopBookListState state = Get.find<ShopBookListLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            color: Colors.white,
            child: TabBar(
              tabs: _logic.state.tabs.map((e) => Tab(text: e.name)).toList(),
              labelColor: MyColors().getThemeColor(),
              unselectedLabelColor: MyColors.text_color,
              labelStyle: TextStyle(fontSize: Dimensions.font_sp16),
              controller: _logic.state.controller,
              indicatorSize: TabBarIndicatorSize.label,
              indicatorColor: MyColors().getThemeColor(),
              onTap: (value) => _logic.changeTab(value),
            ),
          ),
          Expanded(
              child: FunStateRefresherObx(
            builder: () => ListView.separated(
                itemBuilder: (context, index) {
                  ShopBookListModel model = _logic.list[index];
                  if (state.selectModel?.key == "commend") {
                    return GestureDetector(
                      onTap: () => _logic.jumpToDetail(model.listId.toString()),
                                          child: ShopBookListCommendItem(
                        model: model,
                      ),
                    );
                  } else {
                    return GestureDetector(
                      onTap: () => _logic.jumpToDetail(model.listId.toString()),
                                          child: ShopBookListItem(
                        model: model,
                      ),
                    );
                  }
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
          ))
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    _logic.initTabController(this);
  }
}
