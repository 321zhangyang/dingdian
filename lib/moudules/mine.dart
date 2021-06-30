import 'package:flutter/material.dart';
import 'package:flutter_dingdian/routes/app_routes.dart';
import 'package:get/get.dart';

class MinePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
          alignment: Alignment.center,
          child: TextButton(
              onPressed: () => Get.toNamed(Routes.THEME), child: Text("切换主题"))),
    );
  }
}
