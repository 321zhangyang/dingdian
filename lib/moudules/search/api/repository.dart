import 'package:flutter_dingdian/moudules/search/api/api.dart';
import 'package:flutter_dingdian/moudules/search/model/result.dart';
import 'package:get/get.dart';

class BookSearchRepository {
  final BookSearchApi api = Get.put(BookSearchApi());
  Future<List<BookSearchResultModel>> getSearchResult(Map<String ,dynamic> params) async {
    return api.getSearchResult(params);
  }
}
