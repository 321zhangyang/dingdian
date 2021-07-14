import 'package:flutter/material.dart';
import 'package:flutter_dingdian/constant/constants.dart';
import 'package:flutter_dingdian/moudules/read/logic.dart';
import 'package:get/get.dart';

class ReadBottomSliderWidget extends StatefulWidget {
  const ReadBottomSliderWidget({Key? key}) : super(key: key);

  @override
  _ReadBottomSliderWidgetState createState() => _ReadBottomSliderWidgetState();
}

class _ReadBottomSliderWidgetState extends State<ReadBottomSliderWidget> {
  final BookReadLogic _logic = Get.put(BookReadLogic());
  double _sliderValue = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 30,
        child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
          GestureDetector(
            onTap: () {
              if (_sliderValue > 0) {
                setState(() {
                  _sliderValue = _sliderValue - 1;
                  _logic.resetContent(_sliderValue.toInt());
                });
              }
            },
            child: Container(
                height: 30,
                child: Text(
                  "上一章",
                  style: TextStyle(
                      fontSize: Dimensions.font_sp16,
                      color: MyColors.text_gray_color),
                )),
          ),
          Expanded(
            child: Container(
                height: 30,
                child: Slider(
                    value: _sliderValue,
                    min: 0,
                    divisions: _logic.state.allChapters.length,
                    max: _logic.state.allChapters.length.toDouble(),
                    inactiveColor: Color.fromRGBO(200, 200, 200, 1),
                    onChanged: (value) {
                      setState(() {
                        _sliderValue = value;
                        _logic.resetContent(_sliderValue.toInt());
                      });
                    })),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                _sliderValue = _sliderValue + 1;
                _logic.resetContent(_sliderValue.toInt());
              });
            },
            child: Container(
                height: 30,
                child: Text(
                  "下一章",
                  style: TextStyle(
                      fontSize: Dimensions.font_sp16,
                      color: MyColors.text_gray_color),
                )),
          )
        ]));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
}
