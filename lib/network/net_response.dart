import 'package:flutter_dingdian/network/net_constant.dart';

class NetBaseResponse<T> {
  int? code;
  String? message;
  T? data;
  bool? success;

  NetBaseResponse(this.code, this.message, this.data, this.success);

  NetBaseResponse.fromJson( json) {
    code = json[NetResponseConstant.code];
    message = json[NetResponseConstant.message];
    if (json.containsKey(NetResponseConstant.data)) {
      data = json[NetResponseConstant.data];
    }
    if (code == NetErrorCode.SUCCESS) {
      success = true;
    } else {
      success = false;
    }
    // if (json.containsKey(NetResponseConstant.data)) {
    //   //判断是否是数组
    //   if (json[NetResponseConstant.data] is List) {
    //     (json[NetResponseConstant.data] as List).forEach((item) {
    //       if (T.toString() == "String") {
    //         listData.add(item.toString() as T);
    //       } else {
    //         listData.add(NetEntityFactory.generateOBJ<T>(item));
    //       }
    //     });
    //   } else {
    //     if (T.toString() == "String") {
    //       data = json[NetResponseConstant.data].toString() as T;
    //     } else if (T.toString() == "Map<dynamic, dynamic>") {
    //       data = json[NetResponseConstant.data] as T;
    //     } else {
    //       data = NetEntityFactory.generateOBJ(json[NetResponseConstant.data]);
    //     }
    //   }
    // }
  }
}
