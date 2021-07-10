import 'package:flutter_dingdian/moudules/read/api/api.dart';
import 'package:flutter_dingdian/moudules/read/model/content_model.dart';
import 'package:get/get.dart';

class BookReadRepository {
  final BookReadApi api = Get.put(BookReadApi());
  Future<BookChapterContentModel> getBookChapterContent(String url) {
    return api.getBookChapterContent(url);
  }
}
