import 'package:flutter/material.dart';
import 'package:happy_android_flutter/pages/user/about.dart';
import 'package:happy_android_flutter/pages/user/coin.dart';
import 'package:happy_android_flutter/pages/user/mark.dart';
import 'package:happy_android_flutter/pages/user/settings.dart';

class Routes {
  static String root = "/home_view";
  static String coinPage = "/coin";
  static String markPage = "/mark";
  static String settingsPage = "/settings";
  static String aboutPage = "/about";

  static Map<String, WidgetBuilder> routes = {};

  static void init() {
    /*routes[dailyWordPage] = (context) => DailyWordPage();*/
    routes[coinPage] = (context) => CoinPage();
    routes[markPage] = (context) => MarkPage();
    routes[settingsPage] = (context) => SettingsPage();
    routes[aboutPage] = (context) => AboutPage();
  }
}
