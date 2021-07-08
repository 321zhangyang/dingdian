import 'package:flutter_dingdian/moudules/detail/model/info_model.dart';
import 'package:hive/hive.dart';

class LocalBookConfigRepository {
  static final String searhHistory = "search_history";
  static final String keyTheme = "theme";
  static final String readHistory = "book_history";

  // 搜索页面记录本地方法
  static saveSearchHistory(String value) async {
    var box = await Hive.openBox("book");
    List<String>? historys = box.get(searhHistory);
    if (historys == null) {
      historys = [];
    }
    if (historys.contains(value)) {
      historys.remove(value);
    }
    historys.add(value);
    box.put(searhHistory, historys);
  }

  static Future<List> getSearchHistory() async {
    var box = await Hive.openBox("book");
    List? history = box.get(searhHistory);
    return history ?? [];
  }

  static clearSearchHistory() async {
    var box = await Hive.openBox("book");
    box.delete(searhHistory);
  }

  //主题本地化操作
  static saveTheme(String value) async {
    var box = await Hive.openBox("book");
    box.put(keyTheme, value);
  }

  static Future<String?> getThemeKey() async {
    var box = await Hive.openBox("book");
    String? themeKey = box.get(keyTheme) ?? "经典蓝";
    return themeKey;
  }

  //图书查看历史
  static saveBookReadHistroy(BookDetailInfoModel model) async {
    var box = await Hive.openBox("book");
    List? historys = box.get(readHistory);
    if (historys == null) {
      historys = [];
    } else {
      for (var i = 0; i < historys.length; i++) {
        BookDetailInfoModel item = historys[i];
        if (item.id == model.id) {
          historys.removeAt(i);
        }
      }
    }
    historys.add(model);
    print(historys);
    box.put(readHistory, historys);
  }

  static getBookReadHistroy() async {
    var box = await Hive.openBox("book");
    return box.get(readHistory) ?? [];
  }
}
