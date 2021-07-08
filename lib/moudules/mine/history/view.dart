import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dingdian/constant/constants.dart';
import 'package:flutter_dingdian/moudules/common/widgets/segment/segment.dart';
import 'package:flutter_dingdian/moudules/mine/history/widgets/item.dart';

import 'package:fun_flutter_kit/state/src/controller/fun_state_obx.dart';
import 'package:get/get.dart';

import 'logic.dart';
import 'state.dart';

class MineReadHistoryPage extends StatelessWidget {
  final MineReadHistoryLogic _logic = Get.put(MineReadHistoryLogic());
  final MineReadHistoryState state = Get.find<MineReadHistoryLogic>().state;

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
            actions: [
        Container(
          width: 56,
          height: 10,
        )
      ],
      ),
      body: FunStateObx(
        controller: _logic,
        builder: () {
          return Container(
              child: ListView.separated(
                  itemBuilder: (context, index) {
                    return MineReadHistoryListItem(model: _logic.state.list[index]);
                  },
                  separatorBuilder: (context, index) {
                    return Divider(
                      height: 1.0,
                      indent: 30.0,
                      color: Color.fromRGBO(240, 240, 240, 1),
                    );
                  },
                  itemCount: state.list.length));
        },
      ),
    );
  }
}
