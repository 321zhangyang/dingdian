import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'theme_logic.dart';
import 'theme_state.dart';


class ThemePage extends StatelessWidget {
  final ThemeLogic _logic = Get.put(ThemeLogic());
  final ThemeState state = Get.find<ThemeLogic>().state;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: ExpansionTile(
          leading: Icon(Icons.color_lens),
          title: Text('颜色主题'),
          initiallyExpanded: false,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
              child: Wrap(
                spacing: 8,
                runSpacing: 8,
                children: state.themeColorMap.keys.map((key) {
                  Color value = state.themeColorMap[key]!;
                  
                  return InkWell(
                  
                    onTap: () {
                      print(value);
        
                      _logic.changeThemeColor(value,key);
                    },
                    child: Container(
                      width: 40,
                      height: 40,
                      color: value,
                      child: state.colorKey == key
                          ? Icon(
                              Icons.done,
                              color: Colors.white,
                            )
                          : null,
                    ),
                  );
                }).toList(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
