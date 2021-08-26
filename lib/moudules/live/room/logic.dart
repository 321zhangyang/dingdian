
import 'package:flutter_dingdian/moudules/live/api/Repository.dart';
import 'package:flutter_dingdian/routes/app_routes.dart';
import 'package:fun_flutter_kit/state/src/controller/fun_state_list_refresher_controller.dart';
import 'package:get/get.dart';

import 'state.dart';

class LiveRoomLogic extends FunStateListRefresherController {
  final state = LiveRoomState();
    final repository = Get.put(LiveRepository());
  @override
  Future<List> onLoadData(int pageNum, {int? pageSize}) async {
    List datas = await repository.getRoomList(Get.arguments["address"]);
    return datas;
  }
  
  jumpToPlay(String address,String title) {
    Get.toNamed(Routes.PLAY, arguments: {"address": address,"title":title});
  }
}
