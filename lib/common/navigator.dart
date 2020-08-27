import 'package:flutter/cupertino.dart';
import 'package:happy_android_flutter/widget/custom_web_view.dart';

class AppNavigator {
  static pushWeb(BuildContext context, String url, String title, int id, bool collect) {
    Navigator.push(context, CupertinoPageRoute(builder: (context) {
      return CustomWebView(url: url, title: title, id: id, collect: collect);
    }));
  }

  static push(
      {@required BuildContext context,
      Widget scene,
      bool isFullScreen = false}) {
    Navigator.push(
      context,
      CupertinoPageRoute(
        fullscreenDialog: isFullScreen,
        builder: (BuildContext context) => scene,
      ),
    );
  }
}
