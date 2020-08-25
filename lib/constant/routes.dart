import 'package:flutter/material.dart';
import 'package:happy_android_flutter/pages/user/child/about_page.dart';
import 'package:happy_android_flutter/pages/user/child/coin_page.dart';
import 'package:happy_android_flutter/pages/user/child/favourite_page.dart';
import 'package:happy_android_flutter/pages/user/child/settings_page.dart';

class Routes {
  static String root = "/home_view";
  static String coinPage = "/coin_page";
  static String favouritePage = "/favourite_page";
  static String settingsPage = "/settings_page";
  static String aboutPage = "/about_page";

  static Map<String, WidgetBuilder> routes = {};

  static void init() {
    /*routes[dailyWordPage] = (context) => DailyWordPage();*/
    routes[coinPage] = (context) => CoinPage();
    routes[favouritePage] = (context) => FavouritePage();
    routes[settingsPage] = (context) => SettingsPage();
    routes[aboutPage] = (context) => AboutPage();
  }
}
