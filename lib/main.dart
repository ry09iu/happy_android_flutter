import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:happy_android_flutter/common/global.dart';
import 'package:happy_android_flutter/constant/app_colors.dart';
import 'package:happy_android_flutter/constant/routes.dart';
import 'package:happy_android_flutter/pages/home_view.dart';

void main() {
  Global.init(() {
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  MyApp() {
    // 初始化路由
    Routes.init();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: AppColor.primaryColor,
        /*platform: TargetPlatform.iOS,*/ //右滑返回
      ),
      title: '玩 Android',
      routes: Routes.routes,
      home: HomeView(),
    );
  }
}
