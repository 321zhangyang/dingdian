import 'package:flutter_dingdian/local/local_config_repository.dart';
import 'package:flutter_dingdian/moudules/detail/api/repository.dart';
import 'package:flutter_dingdian/moudules/detail/model/info_model.dart';
import 'package:flutter_dingdian/routes/app_routes.dart';
import 'package:flutter_dingdian/utils/db/DbHelper.dart';
import 'package:fun_flutter_kit/state/src/controller/fun_state_action_controller.dart';
import 'package:get/get.dart';

import 'state.dart';

class BookDetailLogic extends FunStateActionController {
  final state = BookDetailState();
  final _repository = Get.put(BookDetailInfoRepository());

  onScroll(offset) {
    double alpha = offset / state.appBarHeight;
    if (alpha < 0) {
      alpha = 0;
    } else if (alpha > 1) {
      alpha = 1;
    }
    state.alpha = alpha;
    update();
  }

  @override
  void onInit() {
    super.onInit();

    loadData();
  }

  //直接阅读
  readBook() {
    //添加历史阅读记录
    LocalBookConfigRepository.saveBookReadHistroy(state.model!);
    //跳转阅读
    Get.toNamed(Routes.READ, arguments: {"model": state.model});
  }

  //添加图书到书架
  addOrRemoveBookToShelf(BookDetailInfoModel model) async {
    if (state.isInShelf == false) {
      await DbHelper.instance.addBooks([model]);
      state.isInShelf = true;
    } else {
      await DbHelper.instance.delBook(model.id!);
      state.isInShelf = false;
    }
    update();
    //DbHelper.instance.addBooks([model]);
  }

  //展示或者收起作者还写过
  showSameUser() {
    state.showAllUser = !state.showAllUser!;
    update();
  }

  int getSameUsersLength() {
    if (state.model!.sameUserBooks!.length > 3) {
      if (state.showAllUser == true) {
        return state.model!.sameUserBooks!.length;
      } else {
        return 3;
      }
    } else {
      return state.model!.sameUserBooks!.length;
    }
  }

  @override
  Future onLoadData() async {
    //拼接地址 id删除后三位 将剩余的id + 1,然后再拼接
    String bookId = Get.arguments["bookId"];
    int index = bookId.length > 3
        ? int.parse(bookId.substring(0, bookId.length - 3)) + 1
        : 1;
    String url = "$index/$bookId/info.html";
    BookDetailInfoModel model = await _repository.getChoose(url);
    state.model = model;
    if (model.sameUserBooks != null) {
      state.showAllUser = model.sameUserBooks!.length > 3 ? false : true;
    }
    var book = await DbHelper.instance.getBook(model.id!);
    //判断是否加入过书架
    if (book != null) {
      //书架里有,更新本地数据库
      state.isInShelf = true;
      DbHelper.instance.updBook(model.lastChapter ?? "", model.lastTime ?? "",
          model.lastChapterId ?? 0, model.bookStatus ?? "", model.id!);
      state.model?.cChapter = book.cChapter;
      state.model?.cChapterPage = book.cChapterPage;
    } else {
      //书架没有,不进行操作,从头开始阅读
      state.isInShelf = false;
      state.model?.cChapter = 0;
      state.model?.cChapterPage = 0;
    }
    return model;
  }

  jumpToDirectory() {
    Get.toNamed(Routes.DETAILDIRECTORY,
        arguments: {"title": state.model?.name, "bookId": state.model?.id});
  }

  jumpToDetail(String bookId) {
    print("嘿嘿嘿额");
  }
}
