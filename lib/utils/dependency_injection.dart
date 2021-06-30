import 'package:flutter_dingdian/network/net_utils.dart';
import 'package:flutter_dingdian/provider/net_config_service.dart';
import 'package:get/get.dart';

/// 依赖注入
class DenpendencyInjection {
  static Future<void> init() async {
    // dio配置信息
    await Get.putAsync(() => NetConfigController().init());
    //  网络请求
    Get.put(NetUtils());
  }
}
