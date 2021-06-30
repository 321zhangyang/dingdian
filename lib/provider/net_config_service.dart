
import 'package:flutter_dingdian/network/interceptor/header_interceptor.dart';
import 'package:flutter_dingdian/network/interceptor/log_interceptor.dart';
import 'package:flutter_dingdian/network/net_config.dart';
import 'package:flutter_dingdian/network/net_constant.dart';
import 'package:get/get.dart';

class NetConfigController extends GetxService {
  Future<NetConfig> init() async {
    NetConfig dioConfig = NetConfig();
    dioConfig.init(NetBaseApi.BASE_URL,
        proxy: '', interceptors: [HeaderInterceptors(),LogInterceptor()]);
    return dioConfig;
  }
}
