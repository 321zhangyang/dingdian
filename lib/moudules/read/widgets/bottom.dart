import 'package:flutter/material.dart';
import 'package:flutter_dingdian/moudules/read/widgets/menu.dart';
import 'package:flutter_dingdian/moudules/read/widgets/slider.dart';

class ReadBottomWidget extends StatelessWidget {
  const ReadBottomWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      padding: EdgeInsets.fromLTRB(15, 15, 15, 15),
      color: Color.fromRGBO(1, 0, 0, 1),
      child: Column(
        children: [
           ReadBottomSliderWidget(),
           ReadBottomMenuWidget()
        ],
      ),
    );
  }
}
