import 'package:event_bus/event_bus.dart';
import 'package:happy_android_flutter/common/data_tool.dart';

//设置一些环节变量 全局的变量之类的
class Application {
  static bool isDebug = true;

  //事件总线
  static EventBus eventBus;

  //是否登录
  static bool isLogin = false;

  static void init() async {
    await dataTools.isLogin().then((value) {
      isLogin = value;
    });
  }
}
