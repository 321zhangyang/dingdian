import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dingdian/constant/constants.dart';
import 'package:flutter_dingdian/moudules/common/widgets/empty/common_empty.dart';
import 'package:flutter_dingdian/moudules/live/model/channel_model.dart';
import 'package:flutter_dingdian/utils/image/image_utils.dart';
import 'package:flutter_dingdian/utils/image/load_image.dart';
import 'package:fun_flutter_kit/fun_flutter_kit.dart';
import 'package:get/get.dart';

import 'logic.dart';
import 'state.dart';

class LiveChannelPage extends StatelessWidget {
  final LiveChannelLogic logic = Get.put(LiveChannelLogic());
  final LiveChannelState state = Get.find<LiveChannelLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("频道列表"),
        elevation: 0,
      ),
      body: FunStateObx(
          controller: logic,
          onEmpty: CommonEmptyWidget(),
          builder: () {
            return GridView.builder(
              padding: EdgeInsets.fromLTRB(15, 15, 15, 15),
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 15,
                  crossAxisSpacing: 20,
                  childAspectRatio: 0.7),
              itemCount: logic.list.length,
              itemBuilder: (context, index) {
                LiveChannelListModel model = logic.list[index];
                return GestureDetector(
                    onTap: () {
                     logic.jumpToRoomList(model.address!);
                    },
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          LoadImage(
                            ImageUtils.getNetWorkPath(model.xinimg ?? ""),
                            holderImg: "app_placeholder",
                            width: (ScreenUtil.getInstance().screenWidth - 30- 40)/3,
                            height: (ScreenUtil.getInstance().screenWidth - 30- 40)/3,
                          ),
                          Gaps.vGap10,
                          Text(
                            model.title ?? "",
                            style: TextStyle(fontSize: Dimensions.font_sp14),
                            maxLines: 1,
                          ),
                        ],
                      ),
                    ));
              },
            );
          }),
    );
  }
}
