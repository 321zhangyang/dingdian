import 'package:hive/hive.dart';

class LocalBookConfigRepository {
  static final String keyHistory = "search_history";
  static final String keyTheme = "theme";

  // 搜索页面记录本地方法
  static saveHistory(String value) async {
    var box = await Hive.openBox("book");
    List<String>? historys = box.get(keyHistory);
    if (historys == null) {
      historys = [];
    }
    if (historys.contains(value)) {
      historys.remove(value);
    }
    historys.add(value);
    box.put(keyHistory, historys);
  }

  static Future<List> getHistory() async {
    var box = await Hive.openBox("book");
    List? history = box.get(keyHistory);
    return history ?? [];
  }

  static clearHistory() async {
    var box = await Hive.openBox("book");
    box.delete(keyHistory);
  }

  static saveTheme(String value) async {
    var box = await Hive.openBox("book");
    box.put(keyTheme, value);
  }

  static Future<String?> getThemeKey() async {
    var box = await Hive.openBox("book");
    String? themeKey = box.get(keyTheme) ?? "经典蓝";
    return themeKey;
  }
}
