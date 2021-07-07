import 'package:flutter/material.dart';
import 'package:flutter_dingdian/constant/constants.dart';
import 'package:flutter_dingdian/moudules/search/logic.dart';
import 'package:fun_flutter_kit/fun_flutter_kit.dart';
import 'package:get/get.dart';

class SearchHistoryWidget extends StatelessWidget {
  final BookSearchLogic _logic = Get.find<BookSearchLogic>();
  @override
  Widget build(BuildContext context) {
    return FunStateObx(
      controller: _logic,
      builder: () {
        return _logic.state.historys.length > 0 ? Container(
          padding: EdgeInsets.fromLTRB(15, 10, 10, 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    "搜索历史",
                    style: TextStyle(
                        fontSize: Dimensions.font_sp18,
                        color: MyColors.text_color,
                        fontWeight: FontWeight.w500),
                  ),
                  Expanded(child: Text("")),
                  TextButton(
                      onPressed: () => _logic.cleanHistory(),
                      child: Text(
                        "清空",
                        style: TextStyle(
                            fontSize: Dimensions.font_sp16,
                            color: MyColors.text_gray_color),
                      ))
                ],
              ),
              Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children:
                      List.generate(_logic.state.historys.length, (index) {
                    return GestureDetector(
                      onTap: () => null,
                      child: Container(
                        height: 35,
                        padding: EdgeInsets.fromLTRB(10, 8, 10, 8),
                        decoration: BoxDecoration(
                            color: Color.fromRGBO(245, 245, 245, 1),
                            borderRadius: BorderRadius.circular(12)),
                        child: Text(
                          _logic.state.historys[index],
                          style: TextStyle(
                              fontSize: Dimensions.font_sp14,
                              color: MyColors.text_color),
                        ),
                      ),
                    );
                  }))
            ],
          ),
        ) : Container();
      },
    );
  }
}
