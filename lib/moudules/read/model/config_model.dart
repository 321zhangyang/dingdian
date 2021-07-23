
import 'package:hive_flutter/hive_flutter.dart';
part 'config_model.g.dart';
@HiveType(typeId: 3)
class BookReadConfigModel extends HiveObject {
  @HiveField(0)
  //第几章
  int? index;
  @HiveField(1)
  //背景
  String? theme;
  @HiveField(2)
  //字体大小
  int? font;
  @HiveField(3)
  //行间距
  double? height;
  @HiveField(4)
  //行间距
  int? turnType;
  @HiveField(5)
  //字体类型
  String? fontFamily;
}