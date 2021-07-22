import 'package:flutter/material.dart';
import 'package:flutter_dingdian/constant/colors.dart';
import 'package:flutter_dingdian/constant/dimensions.dart';
import 'package:flutter_dingdian/constant/gaps.dart';
import 'package:flutter_dingdian/moudules/detail/direcory/widgets/item.dart';
import 'package:flutter_dingdian/moudules/detail/model/directory_model.dart';
import 'package:flutter_dingdian/moudules/read/logic.dart';
import 'package:flutter_dingdian/utils/image/load_image.dart';
import 'package:get/get.dart';

class ReadDirectoryWidget extends StatefulWidget {
  @override
  _ReadDirectoryWidgetState createState() => _ReadDirectoryWidgetState();
}

class _ReadDirectoryWidgetState extends State<ReadDirectoryWidget> {
  final BookReadLogic _logic = Get.put(BookReadLogic());
  ScrollController? _scrollController;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            _logic.state.chapterModel!.name ?? "",
            style: TextStyle(
                fontSize: Dimensions.font_sp18, color: MyColors.text_color),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          leadingWidth: 50,
          actions: [
            GestureDetector(
              onTap: () {
                _logic.sortTheDirectory();
              },
              child: Container(
                width: 50,
                height: 30,
                alignment: Alignment.center,
                child: LoadAssetImage(
                  _logic.state.positive == true
                      ? "KKStriveImg_readV_categoryDESC_Normal"
                      : "KKStriveImg_readV_categoryASC_Normal",
                  width: 30,
                  height: 30,
                ),
              ),
            ),
          ],
        ),
        body: SafeArea(
          child: Container(
            color: Colors.white,
            child: ListView.builder(
              controller: _scrollController,
              padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
              itemBuilder: (context, index) {
                TwoList item = _logic.state.dirChapters[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.pop(_logic.state.readKey.currentContext!);
                    Future.delayed(Duration(microseconds: 300))
                        .then((value) {
                           _logic.changeChapter(index);
                        });
                  },
                  child: BookDirectoryItemWidget(
                    item: item,
                    isDownload: item.hasContent == 2 ? true : false,
                    select: item.id == _logic.state.cContentModel!.cid!,
                  ),
                );
              },
              itemCount: _logic.state.dirChapters.length,
            ),
          ),
        ));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController = ScrollController(
        initialScrollOffset: (_logic.state.bookModel!.cChapter! - 5) * 50);
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController?.dispose();
  }
}
