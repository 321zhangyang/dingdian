import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:oktoast/oktoast.dart';

/// Toast工具类
class Toast {

  static void show(String msg) {
//    if (msg == null) {
////      return;
////    }
    EasyLoading.show(status: msg);
//    showToast(
//      msg,
//      duration: Duration(milliseconds: duration),
//      dismissOtherToast: true
//    );
  }

  static void showLoadingText({String msg = '加载中...'}) {
    EasyLoading.show(status: msg);
  }

  static void showToast(String msg, {int duration = 1}) {
    EasyLoading.showToast(msg,duration: Duration(seconds: duration));
  }

  static void showSuccess(String msg, {int duration = 1}) {
    EasyLoading.showSuccess(msg,duration: Duration(seconds: duration));
  }
  static void showError(String msg, {int duration = 1}) {
    EasyLoading.showError(msg,duration: Duration(seconds: duration));
  }
  static void showInfo(String msg, {int duration = 1}) {
    EasyLoading.showInfo(msg,duration: Duration(seconds: duration) );
  }


  static void dismiss() {
    EasyLoading.dismiss();
//    dismissAllToast();
  }
}
