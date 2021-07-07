import 'package:hive/hive.dart';

class SearchHistoryRepository {
  static final String keyHistory = "search_history";

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
}
