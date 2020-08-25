import 'package:flutter/cupertino.dart';
import 'package:happy_android_flutter/widget/custom_web_view.dart';

class AppNavigator {
  static pushWeb(BuildContext context, String url, String title) {
    Navigator.push(context, CupertinoPageRoute(builder: (context) {
      return CustomWebView(url: url, title: title);
    }));
  }

  static push(BuildContext context, Widget scene) {
    Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (BuildContext context) => scene,
      ),
    );
  }
}
