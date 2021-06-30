import 'package:flutter/material.dart';
import 'package:flutter_dingdian/theme/theme_logic.dart';
import 'package:get/get.dart';

class ThemeSetPage extends StatefulWidget {
  @override
  _ThemeSetPageState createState() => _ThemeSetPageState();
}

class _ThemeSetPageState extends State<ThemeSetPage> {
  final _logic = Get.find<ThemeLogic>();
  // Map<String, Color> themeColorMap = {
  //   'gray': Colors.grey,
  //   'blue': Colors.blue,
  //   'blueAccent': Colors.blueAccent,
  //   'cyan': Colors.cyan,
  //   'deepPurple': Colors.purple,
  //   'deepPurpleAccent': Colors.deepPurpleAccent,
  //   'deepOrange': Colors.orange,
  //   'green': Colors.green,
  //   'indigo': Colors.indigo,
  //   'indigoAccent': Colors.indigoAccent,
  //   'orange': Colors.orange,
  //   'purple': Colors.purple,
  //   'pink': Colors.pink,
  //   'red': Colors.red,
  //   'teal': Colors.teal,
  //   'black': Colors.black,
  // };

    Map<String, Color> themeColorMap = {
    '大地棕': Color.fromRGBO(200, 142, 94, 1),
    '经典蓝':  Color.fromRGBO(0, 163, 237, 1),
    '活力红':  Color.fromRGBO(219, 25, 21, 1),
    '酷炫黑':  Color.fromRGBO(40, 40, 40, 1),
    '新鲜橙':  Color.fromRGBO(255, 90, 30, 1),
    '健康绿':  Color.fromRGBO(59, 174, 94, 1),
    '高贵紫':  Color.fromRGBO(84, 29, 121, 1),
    '可爱粉':  Color.fromRGBO(255, 103, 142, 1),
    '自然青':  Color.fromRGBO(0, 175, 137, 1),
    '魅力黄':  Color.fromRGBO(255, 192, 83, 1),
  };
  String? _colorKey;

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
                children: themeColorMap.keys.map((key) {
                  Color value = themeColorMap[key]!;
                  
                  return InkWell(
                  
                    onTap: () {
                      print(value);
                      setState(() {
                        _colorKey = key;
                      });
                      _logic.changeThemeColor(value);
                    },
                    child: Container(
                      width: 40,
                      height: 40,
                      color: value,
                      child: _colorKey == key
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
