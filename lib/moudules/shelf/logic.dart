import 'package:flustars/flustars.dart';
import 'package:flutter_dingdian/local/local_config_repository.dart';
import 'package:flutter_dingdian/moudules/detail/model/info_model.dart';
import 'package:flutter_dingdian/routes/app_routes.dart';
import 'package:flutter_dingdian/utils/db/DbHelper.dart';
import 'package:fun_flutter_kit/fun_flutter_kit.dart';
import 'package:get/get.dart';

import 'state.dart';

class BookShelfLogic extends FunStateListRefresherController {
  final state = BookShelfState();

  @override
  Future<List> onLoadData(int pageNum, {int? pageSize}) async {
    List<BookDetailInfoModel> lists = await DbHelper.instance.getBooks();
    return lists;
  }

  deleteBookFromShelf(int id) {
    DbHelper.instance.delBook(id);
    pullToRefresh();
  }

  jumpToRead(BookDetailInfoModel model) {
    //添加历史阅读记录
    LocalBookConfigRepository.saveBookReadHistroy(model);
    //跳转阅读
    Get.toNamed(Routes.READ, arguments: {"model": model});

    _sort(model);
  }

  _sort(BookDetailInfoModel model) async {
    var book = model;
    book.sortTime = DateUtil.getNowDateMs();

    list.sort((o1, o2) => o2.sortTime.compareTo(o1.sortTime));
    update();
    await DbHelper.instance.sortBook(model.id!);
  }
}
