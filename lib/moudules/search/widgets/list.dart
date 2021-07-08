import 'package:flutter/material.dart';
import 'package:flutter_dingdian/moudules/search/logic.dart';
import 'package:flutter_dingdian/moudules/search/widgets/list_item.dart';
import 'package:fun_flutter_kit/fun_flutter_kit.dart';
import 'package:get/get.dart';

class BookSearchResultListWidget extends StatelessWidget {
  BookSearchResultListWidget({Key? key}) : super(key: key);
  final BookSearchLogic _logic = Get.put(BookSearchLogic());
  @override
  Widget build(BuildContext context) {
    return Container(
      child: FunStateRefresherObx(
        controller: _logic,
        enablePullUp: true,
        builder: () {
          return ListView.separated(
            shrinkWrap: true,
              itemBuilder: (context, index) {
                return BookSearchResultListItem(model: _logic.list[index],);
              },
              separatorBuilder: (context, index) {
                return Divider(height: 0.5,);
              },
              itemCount: _logic.list.length);
        },
      ),
    );
  }
}
