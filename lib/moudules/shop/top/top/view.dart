import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dingdian/constant/constants.dart';
import 'package:flutter_dingdian/moudules/common/model/tab_model.dart';
import 'package:flutter_dingdian/moudules/common/widgets/empty/common_empty.dart';
import 'package:flutter_dingdian/moudules/common/widgets/error/common_error.dart';
import 'package:flutter_dingdian/moudules/shop/choose/model/list_model.dart';
import 'package:flutter_dingdian/moudules/shop/top/top/widgets/list_item.dart';
import 'package:fun_flutter_kit/fun_flutter_kit.dart';
import 'package:get/get.dart';

import 'logic.dart';
import 'state.dart';

class ShopTopPage extends StatefulWidget {
  @override
  _ShopTopPageState createState() => _ShopTopPageState();
}

class _ShopTopPageState extends State<ShopTopPage>
    with TickerProviderStateMixin {
  final ShopTopLogic _logic = Get.put(ShopTopLogic());

  final ShopTopState state = Get.find<ShopTopLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FunStateObx(
        controller: _logic,
        builder: () => Container(
          color: Colors.white,
          child: Column(
            children: [
              Container(
                child: TabBar(
                  tabs:
                      _logic.state.tabs.map((e) => Tab(text: e.name)).toList(),
                  labelColor: MyColors().getThemeColor(),
                  unselectedLabelColor: MyColors.text_color,
                  labelStyle: TextStyle(fontSize: Dimensions.font_sp16),
                  controller: _logic.state.controller,
                  indicatorSize: TabBarIndicatorSize.label,
                  indicatorColor: MyColors().getThemeColor(),
                  onTap: (value) => _logic.changeTab(value),
                ),
              ),
              Container(
                height: 1,
                color: Color.fromRGBO(240, 240, 240, 1),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    color: Colors.white,
                    width: 100,
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        BookTabModel model = _logic.state.subTabs[index];
                        return GestureDetector(
                          onTap: () => _logic.changeSubTab(index),
                          child: Container(
                            alignment: Alignment.center,
                            color: model.isSelect == true
                                ? Color.fromRGBO(240, 240, 240, 1)
                                : Colors.white,
                            height: 50,
                            child: Text(
                              model.name!,
                              style: TextStyle(
                                  fontSize: Dimensions.font_sp16,
                                  color: model.isSelect == true
                                      ? MyColors().getThemeColor()
                                      : MyColors.text_color),
                            ),
                          ),
                        );
                      },
                      itemCount: _logic.state.subTabs.length,
                    ),
                  ),
                  Container(
                    color: Colors.white,
                    width: ScreenUtil.getInstance().screenWidth - 100,
                    height: ScreenUtil.getInstance().screenHeight -
                        50 -
                        50 -
                        ScreenUtil.getInstance().appBarHeight -
                        ScreenUtil.getInstance().bottomBarHeight -
                        ScreenUtil.getInstance().statusBarHeight -
                        47,
                    child: FunStateRefresherObx(
                      onEmpty: CommonEmptyWidget(),
                      onError: (error) {
                        return CommonErrorWidget(
                          click: () {
                            _logic.pullToRefresh();
                          },
                        );
                      },
                      controller: _logic,
                      enablePullUp: true,
                      builder: () => ListView.builder(
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          BookList model = _logic.list[index];
                          return ShopTopListItem(
                            index: index,
                            model: model,
                          );
                        },
                        itemCount: _logic.list.length,
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    _logic.initTabController(this);
  }
}
