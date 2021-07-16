import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dingdian/constant/constants.dart';
import 'package:flutter_dingdian/moudules/common/widgets/button/button.dart';
import 'package:flutter_dingdian/moudules/common/widgets/segment/segment.dart';
import 'package:flutter_dingdian/moudules/detail/model/info_model.dart';
import 'package:flutter_dingdian/routes/app_routes.dart';
import 'package:flutter_dingdian/utils/image/image_utils.dart';
import 'package:flutter_dingdian/utils/image/load_image.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fun_flutter_kit/fun_flutter_kit.dart';
import 'package:get/get.dart';

import 'logic.dart';

class BookShelfPage extends StatelessWidget {
  final BookShelfLogic _logic = Get.put(BookShelfLogic());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leadingWidth: ScreenUtil.getInstance().getSp(80),
        leading: Container(),
        title: SegmentBar(
            titleNames: _logic.state.titles,
            itemWidth: ScreenUtil.getInstance().getSp(70),
            itemHeight: ScreenUtil.getInstance().getSp(35),
            selectedColor: Colors.white,
            defaultColor: MyColors().getThemeColor(),
            onSelectChanged: (position) {}),
        actions: [
          GestureDetector(
            onTap: () => Get.toNamed(Routes.SEARCH),
            child: Container(
              width: ScreenUtil.getInstance().getSp(80),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  XXMyIconBtn(
                    iconSting: "search_btn_Normal",
                    width: ScreenUtil.getInstance().getSp(25),
                    height: ScreenUtil.getInstance().getSp(25),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
      body: FunStateRefresherObx(
        controller: _logic,
        builder: () {
          return ListView.separated(
            separatorBuilder: (context, index) {
              return Divider(
                indent: 15,
                height: 1,
              );
            },
            itemBuilder: (context, index) {
              BookDetailInfoModel model = _logic.list[index];
              return Container(
                color: Colors.white,
                child: Slidable(
                    actionPane: SlidableDrawerActionPane(),
                    actionExtentRatio: 0.25,
                    secondaryActions: [
                      IconSlideAction(
                        caption: "删除",
                        color: Colors.red,
                        icon: Icons.delete,
                        onTap: () {
                          _logic.deleteBookFromShelf(model.id!);
                        },
                        closeOnTap: true,
                      )
                    ],
                    child: GestureDetector(
                      onTap: () => _logic.jumpToRead(model),
                                          child: Container(
                                            color: Colors.white,
                                                                                      child: Container(
                        padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            LoadImage(
                              ImageUtils.getNetWorkPath(model.img ?? ""),
                              holderImg: "app_placeholder",
                              width: 80,
                              height: 80 * 1.35,
                            ),
                            Gaps.hGap15,
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Gaps.vGap15,
                                  Text(
                                    model.name ?? "",
                                    style: TextStyle(
                                        fontSize: Dimensions.font_sp16,
                                        color: MyColors.text_color),
                                  ),
                                  Gaps.vGap10,
                                  Text(
                                    "最近: ${model.lastChapter}",
                                    style: TextStyle(
                                        fontSize: Dimensions.font_sp12,
                                        color: MyColors.text_gray_color),
                                  ),
                                  Gaps.vGap10,
                                  Row(
                                    children: [
                                      LoadAssetImage("clock_small_Normal"),
                                      Gaps.hGap10,
                                      Text(
                                        model.lastTime ?? "",
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                              fontSize: Dimensions.font_sp12,
                                              color: MyColors.text_gray_color),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                                          ),
                    )),
              );
            },
            itemCount: _logic.list.length,
          );
        },
      ),
    );
  }
}
