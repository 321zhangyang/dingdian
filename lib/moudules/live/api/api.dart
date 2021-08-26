import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:fijkplayer/fijkplayer.dart';
import 'package:flutter_dingdian/moudules/live/model/channel_model.dart';
import 'package:flutter_dingdian/moudules/live/model/room_model.dart';
import 'package:flutter_dingdian/network/net_constant.dart';
import 'package:flutter_dingdian/network/net_dio.dart';


class LiveApi {
  final String _channelList = "xcdsw/json.txt";
  final String _roomList = "xcdsw/";

  NetAppDio _dio = NetAppDio.getInstance();

  Future<List<LiveChannelListModel>> getChannelList() async {
    _dio.options.method = "get";
    _dio.options.baseUrl = NetBaseApi.BASE_URL_MAP["live"];
    try {
      var response = await _dio.request(_channelList,
          data: null, queryParameters: null, cancelToken: null);
      var datas = json.decode(response.data)["pingtai"];
      List<LiveChannelListModel> models = [];
      for (Map<String, dynamic> item in datas) {
        LiveChannelListModel model = LiveChannelListModel.fromJson(item);
        models.add(model);
      }
      return models;
    } catch (e) {
      print(e.toString());
      throw "出错了";
    }
  }

  Future<List<LiveRoomListModel>> getRoomList(String url) async {
    _dio.options.method = "get";
    _dio.options.baseUrl = NetBaseApi.BASE_URL_MAP["live"];
    try {
      var response = await _dio.request(_roomList + url,
          data: null, queryParameters: null, cancelToken: null);
      var datas = json.decode(response.data)["zhubo"];
      List<LiveRoomListModel> models = [];
      for (Map<String, dynamic> item in datas) {
        LiveRoomListModel model = LiveRoomListModel.fromJson(item);
        models.add(model);
      }
      return models;
    } catch (e) {
      throw "出错了";
    }
  }
}
