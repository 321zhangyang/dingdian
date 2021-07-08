import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dingdian/constant/colors.dart';
import 'package:flutter_dingdian/constant/dimensions.dart';
import 'package:flutter_dingdian/constant/gaps.dart';
import 'package:get/get.dart';

import 'theme_logic.dart';
import 'theme_state.dart';


class ThemePage extends StatelessWidget {
  final ThemeLogic _logic = Get.put(ThemeLogic());
  final ThemeState state = Get.find<ThemeLogic>().state;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text("换肤"),
      ),
      body: Container(
        child: Padding(
          padding: EdgeInsets.only(left: 20, right: 20, bottom: 20,top: 20),
          child: Wrap(
            spacing: 20,
            runSpacing: 20,
            
            children: state.themeColorMap.keys.map((key) {
              Color value = state.themeColorMap[key]!;
              
              return InkWell(
              
                onTap: () {

                  _logic.changeThemeColor(value,key);
                },
                child: Column(
                  children: [
                    Container(
                      width: (ScreenUtil.getInstance().screenWidth - 60) / 2,
                      height: 50,
                      color: value,
                      child: state.colorKey == key
                          ? Icon(
                              Icons.done,
                              color: Colors.white,
                            )
                          : null,
                    ),
                    Gaps.vGap10,
                    Text(key,style: TextStyle(fontSize: Dimensions.font_sp16,color: MyColors.text_color),)
                  ],
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
