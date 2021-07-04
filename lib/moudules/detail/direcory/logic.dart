import 'package:flutter/material.dart';
import 'package:flutter_dingdian/moudules/detail/api/repository.dart';
import 'package:flutter_dingdian/moudules/detail/model/directory_model.dart';
import 'package:fun_flutter_kit/fun_flutter_kit.dart';
import 'package:get/get.dart';
import 'package:list_group_handler/list_group_handler.dart';

import 'state.dart';

class BookDetailDirectoryLogic extends FunStateActionController {
  final state = BookDetailDirectoryState();
  final _repository = Get.find<BookDetailInfoRepository>();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    loadData();
  }

  @override
  Future onLoadData() async {
    //拼接地址 id删除后三位 将剩余的id + 1,然后再拼接
    String bookId = Get.arguments["bookId"].toString();
    int index = int.parse(bookId.substring(0, bookId.length - 3)) + 1;
    String url = "$index/$bookId/index.html";
    BookDirectoryModel model = await _repository.getBookDirectory(url);
    state.model = model;
    _initGroupHandler();
    return model;
  }

  _initGroupHandler() {
    state.groupHandler = ListViewGroupHandler(
      //日志开关
      openLog: true,
      //分组数量，需要自行根据data设置，默认1
      numberOfSections: state.model!.list!.length,
      //每组cell个数，需要自行根据data设置
      numberOfRowsInSection: (section) =>
          state.model!.list![section].list!.length,
      //indexPath: IndexPath(section,row,index)
      cellForRowAtIndexPath: (indexPath) => Text("哈哈哈哈"),
      //头部
      header: () => Text("header"),
      //占位Placeholder
      emptyPlaceholder: () {
        return Center(
          child: Text("暂无数据！"),
        );
      },
    );
  }
}
