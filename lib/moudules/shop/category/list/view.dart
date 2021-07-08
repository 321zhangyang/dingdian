import 'package:flutter/material.dart';
import 'package:flutter_dingdian/constant/constants.dart';
import 'package:flutter_dingdian/moudules/shop/choose/list/widgets/item.dart';
import 'package:flutter_dingdian/moudules/shop/choose/model/list_model.dart';
import 'package:fun_flutter_kit/state/src/controller/fun_state_obx.dart';
import 'package:get/get.dart';

import 'logic.dart';
import 'state.dart';

class ShopCategoryListPage extends StatefulWidget {
  @override
  _ShopCategoryListPageState createState() => _ShopCategoryListPageState();
}

class _ShopCategoryListPageState extends State<ShopCategoryListPage>
    with TickerProviderStateMixin {
  final ShopCategoryListLogic _logic = Get.put(ShopCategoryListLogic());

  final ShopCategoryListState state = Get.find<ShopCategoryListLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(_logic.state.model?.name ?? ""),
      ),
      body: Column(
        children: [
          TabBar(
            tabs: _logic.state.tabTitles.map((e) => Tab(text: e)).toList(),
            labelColor: MyColors().getThemeColor(),
            unselectedLabelColor: MyColors.text_color,
            labelStyle: TextStyle(fontSize: Dimensions.font_sp16),
            controller: _logic.state.controller,
            indicatorSize: TabBarIndicatorSize.label,
            indicatorColor: MyColors().getThemeColor(),
            onTap: (value) => _logic.changeTab(value),
          ),
          Expanded(
              child: FunStateRefresherObx(
            builder: () => ListView.separated(
                itemBuilder: (context, index) {
                  BookList model = _logic.list[index];
                  return GestureDetector(
                    onTap: () {
                      _logic.jumpToDetail(model.id.toString());
                    },
                    child: ShopChooseListItem(
                      model: model,
                    ),
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
            onEmpty: Text("空的"),
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
