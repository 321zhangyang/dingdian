import 'package:flutter_dingdian/moudules/detail/api/repository.dart';
import 'package:flutter_dingdian/moudules/detail/model/directory_model.dart';
import 'package:get/get.dart';

import 'state.dart';

class BookReadLogic extends GetxController {
  final state = BookReadState();
  final _chapterRepository = Get.find<BookDetailInfoRepository>();


  getBookChapters() async{
      //拼接地址 id删除后三位 将剩余的id + 1,然后再拼接
    String bookId = Get.arguments["bookId"].toString();
    int index = int.parse(bookId.substring(0, bookId.length - 3)) + 1;
    String url = "$index/$bookId/index.html";
    BookDirectoryModel model = await _chapterRepository.getBookDirectory(url);
  }
}
