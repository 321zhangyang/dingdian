import 'package:flutter/material.dart';
import 'package:flutter_dingdian/moudules/common/button/button.dart';
import 'package:flutter_dingdian/moudules/common/segment/segment.dart';
import 'package:flutter_dingdian/theme/theme_logic.dart';
import 'package:flutter_dingdian/utils/image/image_utils.dart';
import 'package:get/get.dart';

class ShopPage extends StatefulWidget {
  @override
  _ShopPageState createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  bool _isCheck = true;
  List<String> titleNames = ["小说", "漫画"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SegmentBar(
            titleNames: titleNames,
            itemWidth: 100,
            itemHeight: 40,
            selectedColor: Colors.white,
            defaultColor: Get.find<ThemeLogic>().state.themeColor,
            onSelectChanged: (position) {
              print("Sagment" + position.toString());
            }),
        leadingWidth: 80,
        leading: Container(

          child: Row(
            children: [
              SizedBox(
                width: 15,
              ),
              Transform.scale(
                scale: 1.6,
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
          Row(
            children: [
              SizedBox(
                width: 40,
              ),
              XXMyIconBtn(
                iconSting: "search_btn_Normal",
                width: 30.0,
                height: 30.0,
              ),
              SizedBox(
                width: 20,
              ),
            ],
          )
        ],
      ),
    );
  }

  void _changed(isCheck) {
    setState(() {
      _isCheck = isCheck;
    });
  }
}
