import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dingdian/constant/constants.dart';
import 'package:flutter_dingdian/moudules/common/widgets/empty/common_empty.dart';
import 'package:flutter_dingdian/moudules/live/model/channel_model.dart';
import 'package:flutter_dingdian/moudules/live/model/room_model.dart';
import 'package:flutter_dingdian/routes/app_routes.dart';
import 'package:flutter_dingdian/utils/image/image_utils.dart';
import 'package:flutter_dingdian/utils/image/load_image.dart';
import 'package:fun_flutter_kit/state/src/controller/fun_state_obx.dart';
import 'package:get/get.dart';

import 'logic.dart';
import 'state.dart';

class LiveRoomPage extends StatelessWidget {
  final LiveRoomLogic logic = Get.put(LiveRoomLogic());
  final LiveRoomState state = Get.find<LiveRoomLogic>().state;

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
                  crossAxisCount: 2,
                  mainAxisSpacing: 0,
                  crossAxisSpacing: 20,
                  childAspectRatio: 0.7),
              itemCount: logic.list.length,
              itemBuilder: (context, index) {
                LiveRoomListModel model = logic.list[index];
                return GestureDetector(
                    onTap: () {
                      logic.jumpToPlay(model.address!,model.title!);
                    },
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          LoadImage(
                            ImageUtils.getNetWorkPath(model.img ?? ""),
                            holderImg: "app_placeholder",
                            width: (ScreenUtil.getInstance().screenWidth - 30)/2,
                            height: (ScreenUtil.getInstance().screenWidth - 30)/2,
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
