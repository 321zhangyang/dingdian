import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dingdian/constant/colors.dart';
import 'package:flutter_dingdian/constant/dimensions.dart';
import 'package:flutter_dingdian/moudules/common/widgets/button/button.dart';
import 'package:flutter_dingdian/moudules/common/widgets/segment/segment.dart';
import 'package:flutter_dingdian/moudules/shop/category/category/view.dart';
import 'package:flutter_dingdian/moudules/shop/choose/choose/view.dart';
import 'package:flutter_dingdian/moudules/shop/list/list/view.dart';
import 'package:flutter_dingdian/moudules/shop/shop/logic.dart';
import 'package:flutter_dingdian/moudules/shop/top/top/view.dart';
import 'package:flutter_dingdian/routes/app_routes.dart';
import 'package:flutter_dingdian/moudules/mine/theme/theme_logic.dart';
import 'package:flutter_dingdian/utils/image/image_utils.dart';
import 'package:get/get.dart';

class ShopPage extends StatefulWidget {
  @override
  _ShopPageState createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> with TickerProviderStateMixin {
  bool _isCheck = true;
  final _logic = Get.put(ShopLogic());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SegmentBar(
            titleNames: _logic.state.titles,
            itemWidth: ScreenUtil.getInstance().getSp(70),
            itemHeight: ScreenUtil.getInstance().getSp(35),
            selectedColor: Colors.white,
            defaultColor: MyColors().getThemeColor(),
            onSelectChanged: (position) {}),
        leadingWidth: ScreenUtil.getInstance().getSp(80),
        leading: Container(
          child: Row(
            children: [
              SizedBox(
                width: 15,
              ),
              Transform.scale(
                scale: ScreenUtil.getInstance().getSp(1.3),
                child: Switch(
                  //来初始化此 Switch 是否被选中。true 表示选中 ，false 表示不选中
                  value: _isCheck,
                  //当 拖动改变状态时的回调。
                  onChanged: _changed,
                  //当 value 是 true 时 滑块的颜色。也就是开的状态时的颜色
                  activeColor: Colors.white,
                  // 当 value 是 true 时 滑道的颜色
                  activeTrackColor: Color.fromRGBO(0, 0, 0, 0.3),
                  // 当 value 是 true 时 滑块上的图片。 如果 activeColor 也设置了  ， 以 activeThumbImage 为准
                  // 如果设置的是网络图片的话。当 滑块 滑到这里 才开始加载。所以 没加载出图片的之前 ，以 activeColor 为准
                  activeThumbImage: AssetImage(
                    ImageUtils.getImgPath("comicIMG_18"),
                  ),

                  // 当 value 是 false 时 滑块的颜色。也就是开的状态时的颜色
                  inactiveThumbColor: Colors.white,
                  // 当 value 是 false 时 滑道的颜色
                  inactiveTrackColor: Color.fromRGBO(0, 0, 0, 0.3),
                  // 当 value 是 false 时 滑块上的图片。 如果 inactiveThumbColor 也设置了  ， 以 inactiveThumbImage 为准
                  inactiveThumbImage:
                      AssetImage(ImageUtils.getImgPath("comicIMG_19")),
                ),
              ),
            ],
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () => Get.toNamed(Routes.SEARCH),
                      child: Container(
              width: ScreenUtil.getInstance().getSp(80),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  XXMyIconBtn(
                    iconSting: "search_btn_Normal",
                    width: ScreenUtil.getInstance().getSp(25),
                    height: ScreenUtil.getInstance().getSp(25),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
      body: Column(
        children: [
          Container(
            color: Colors.white,
            child: TabBar(
              tabs: _logic.state.tabs.map((e) => Tab(text: e)).toList(),
              labelColor: MyColors().getThemeColor(),
              unselectedLabelColor: MyColors.text_color,
              labelStyle: TextStyle(fontSize: Dimensions.font_sp16),
              controller: _logic.state.controller,
              indicatorSize: TabBarIndicatorSize.label,
              onTap: (value) => _logic.changeTab(value),
            ),
          ),
          Expanded(
              child: PageView.builder(
            controller: _logic.state.pageController,
            onPageChanged: (value) => _logic.onPageChanged(value),
            itemCount: _logic.state.tabs.length,
            itemBuilder: (context, index) {
              if (index == 0) {
                return ShopChoosePage();
              } else if (index == 1) {
                return ShopCategoryPage();
              } else if (index == 2) {
                return ShopTopPage();
              } else {
                return ShopBookListPage();
              }
            },
          ))
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    //初始化TabController
    _logic.initTabController(this);
  }

  void _changed(isCheck) {
    setState(() {
      _isCheck = isCheck;
    });
  }
}
