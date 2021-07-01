import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'state.dart';

class ShopLogic extends GetxController {
  final state = ShopState();

  void initTabController(TickerProvider provider) {
    state.controller =
        TabController(vsync: provider, length: state.tabs.length);
    state.pageController = PageController();
  }

  void changeTab(int index) {
    state.pageController?.animateToPage(index,
        duration: Duration(milliseconds: 300), curve: Curves.ease);
  }

  void onPageChanged(int index) {
    state.controller?.animateTo(index, duration: Duration(milliseconds: 300));
  }
}
