
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'Dimensions.dart';

/// 间隔
/// 官方做法：https://github.com/flutter/flutter/pull/54394
class Gaps {
  
  /// 水平间隔
  static const Widget hGap4 = SizedBox(width: Dimensions.gap_dp4);
  static const Widget hGap5 = SizedBox(width: Dimensions.gap_dp5);
  static const Widget hGap8 = SizedBox(width: Dimensions.gap_dp8);
  static const Widget hGap10 = SizedBox(width: Dimensions.gap_dp10);
  static const Widget hGap12 = SizedBox(width: Dimensions.gap_dp12);
  static const Widget hGap15 = SizedBox(width: Dimensions.gap_dp15);
  static const Widget hGap16 = SizedBox(width: Dimensions.gap_dp16);
  static const Widget hGap20 = SizedBox(width: Dimensions.gap_dp20);
  static const Widget hGap24 = SizedBox(width: Dimensions.gap_dp24);
  static const Widget hGap32 = SizedBox(width: Dimensions.gap_dp32);
  
  /// 垂直间隔
  static const Widget vGap3 = SizedBox(height: Dimensions.gap_dp4);
  static const Widget vGap4 = SizedBox(height: Dimensions.gap_dp4);
  static const Widget vGap5 = SizedBox(height: Dimensions.gap_dp5);
  static const Widget vGap8 = SizedBox(height: Dimensions.gap_dp8);
  static const Widget vGap10 = SizedBox(height: Dimensions.gap_dp10);
  static const Widget vGap12 = SizedBox(height: Dimensions.gap_dp12);
  static const Widget vGap15 = SizedBox(height: Dimensions.gap_dp15);
  static const Widget vGap16 = SizedBox(height: Dimensions.gap_dp16);
  static const Widget vGap20 = SizedBox(height: Dimensions.gap_dp20);
  static const Widget vGap24 = SizedBox(height: Dimensions.gap_dp24);
  static const Widget vGap32 = SizedBox(height: Dimensions.gap_dp32);
  static const Widget vGap50 = SizedBox(height: Dimensions.gap_dp50);
  
  static const Widget line = Divider();

  static const Widget vLine = SizedBox(
    width: 0.6,
    height: 24.0,
    child: VerticalDivider(),
  );
  
  static const Widget empty = SizedBox.shrink();
}
