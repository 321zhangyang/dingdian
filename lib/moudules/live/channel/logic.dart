import 'package:flutter_dingdian/moudules/live/api/Repository.dart';
import 'package:flutter_dingdian/routes/app_routes.dart';
import 'package:fun_flutter_kit/fun_flutter_kit.dart';
import 'package:get/get.dart';

import 'state.dart';

class LiveChannelLogic extends FunStateListRefresherController {
  final state = LiveChannelState();
  final repository = Get.put(LiveRepository());
  @override
  Future<List> onLoadData(int pageNum, {int? pageSize}) async {
    List datas = await repository.getChannelList();
    return datas;
  }

    jumpToRoomList(String address) {
    Get.toNamed(Routes.ROOM, arguments: {"address": address});
  }
}
