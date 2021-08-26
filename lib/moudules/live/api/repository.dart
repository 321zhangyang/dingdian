import 'package:flutter_dingdian/moudules/live/api/api.dart';
import 'package:flutter_dingdian/moudules/live/model/channel_model.dart';
import 'package:flutter_dingdian/moudules/live/model/room_model.dart';
import 'package:get/get.dart';

class LiveRepository {
  final LiveApi api = Get.put(LiveApi());

  Future<List<LiveChannelListModel>> getChannelList() async {
    return api.getChannelList();
  }

  Future<List<LiveRoomListModel>> getRoomList(String url) async {
    return api.getRoomList(url);
  }
}
