import 'package:flutter/material.dart';
import 'package:flutter_dingdian/constant/constants.dart';
import 'package:flutter_dingdian/moudules/shop/choose/list/widgets/item.dart';
import 'package:flutter_dingdian/moudules/shop/choose/model/list_model.dart';
import 'package:fun_flutter_kit/fun_flutter_kit.dart';
import 'package:get/get.dart';

import 'logic.dart';
import 'state.dart';

class BookChooseListPage extends StatefulWidget {
  @override
  _BookChooseListPageState createState() => _BookChooseListPageState();
}

class _BookChooseListPageState extends State<BookChooseListPage>
    with TickerProviderStateMixin {
  final ShopChooseListLogic _logic = Get.put(ShopChooseListLogic());

  final ShopChooseListState state = Get.find<ShopChooseListLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(Get.arguments["title"] + "榜"),
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
                  return ShopChooseListItem(model: model,);
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
