import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dingdian/constant/colors.dart';
import 'package:flutter_dingdian/moudules/mine/theme/theme_logic.dart';
import 'package:flutter_dingdian/moudules/tabbar/widgets/tabbar_item.dart';
import 'package:get/get.dart';



class TabBarPage extends StatefulWidget {
  final int selectIndex;

  const TabBarPage({Key? key, this.selectIndex = 0}) : super(key: key);

  @override
  TabBarPageState createState() => new TabBarPageState();
}

class TabBarPageState extends State<TabBarPage> with TickerProviderStateMixin {
  GlobalKey _stackKey = GlobalKey();
  int _currentIndex = 0;
  var _pageController = PageController();
  bool isSelectedFirst = true;

  int homeTopIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double itemWidth = MediaQuery.of(context).size.width / 3;

    return Scaffold(
      key: _stackKey,
      body: PageView.builder(
        itemBuilder: (ctx, index) {
          return pageList[index];
        },
        itemCount: pageList.length,
        controller: _pageController,
        physics: NeverScrollableScrollPhysics(),
        onPageChanged: (value) {
          setState(() {
            _currentIndex = value;
          });
        },
      ),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(canvasColor: Colors.white),
        child: BottomAppBar(
          color: Colors.white,
          child: Row(children: <Widget>[
            Container( height: 50,width: itemWidth, child: tabbar(0)),
            Container( height: 50,width: itemWidth, child: tabbar(1)),
            Container( height: 50,width: itemWidth, child: tabbar(2)),
          ]),
        ),
      ),
    );
  }

  // 自定义tabbaritem
  Widget tabbar(int index) {
    double itemWidth = MediaQuery.of(context).size.width / 3;

    //设置默认未选中的状态
    TextStyle style = TextStyle(fontSize: 12, color: Color.fromRGBO(50, 50, 50, 1));
    String imgUrl = normalImgUrls[index];
    if (_currentIndex == index) {
      //选中的话
      style = TextStyle(fontSize: 12, color: MyColors().getThemeColor());
      imgUrl = selectedImgUrls[index];
    }
    Widget item = Container(
      alignment: Alignment.center,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        child: Container(
          width: itemWidth,
          child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
            SizedBox(
              height: 2,
            ),
            Image.asset(imgUrl,color: _currentIndex == index ? MyColors().getThemeColor() : null,),
            Text(
              appBarTitles[index],
              style: style,
            )
          ]),
        ),
        onTap: () {
          if (_currentIndex != index) {
            if (index == 0) {
              isSelectedFirst = true;
            } else {
              isSelectedFirst = false;
            }
            setState(() {
              _currentIndex = index;
              _pageController.jumpToPage(index);
            });
          }
        },
      ),
    );
    return item;
  }



  @override
  void dispose() {
    super.dispose();
  }

  @override
  void didUpdateWidget(TabBarPage oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }
}
