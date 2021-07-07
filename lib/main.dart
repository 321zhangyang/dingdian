import 'package:flutter/material.dart';
import 'package:flutter_dingdian/moudules/mine/theme/theme_logic.dart';
import 'package:flutter_dingdian/routes/app_pages.dart';
import 'package:flutter_dingdian/routes/app_routes.dart';
import 'package:flutter_dingdian/utils/dependency_injection.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fun_flutter_kit/state/src/fun_state_configuration.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await DenpendencyInjection.init();
  await Hive.initFlutter();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(GetBuilder<ThemeLogic>(
    init: ThemeLogic(),
    initState: (_) {},
    builder: (_) {
      return FunFlutterConfiguration(
        funStateBehavior: FunStateBehavior(
          /// 全局分页参数设置
          paging: FunStatePaging(firstPageNo: 1, pageSize: 10),
        ),
        child: GetMaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: Routes.TABBAR,
          builder: (context, child) => Scaffold(
            body: GestureDetector(
              onTap: () => hideKeyboard(context),
              child: FlutterEasyLoading(child: child),
            ),
          ),
          theme: ThemeData(primaryColor: _.state.themeColor),
          getPages: AppPages.pages,
        ),
      );
    },
  ));
}

void hideKeyboard(BuildContext context) {
  FocusScopeNode currentFocus = FocusScope.of(context);
  if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
    FocusManager.instance.primaryFocus?.unfocus();
  }
}
