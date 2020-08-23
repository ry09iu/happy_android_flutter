import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:share/share.dart';

class CustomWebView extends StatefulWidget {
  final String url;
  final String title;

  CustomWebView({@required this.url, this.title});

  @override
  _CustomWebViewState createState() => _CustomWebViewState();
}

class _CustomWebViewState extends State<CustomWebView> {
  FlutterWebviewPlugin flutterWebviewPlugin = FlutterWebviewPlugin();

  @override
  void deactivate() {
    // TODO: implement deactivate
    super.deactivate();
  }

  @override
  void dispose() {
    flutterWebviewPlugin.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: WebviewScaffold(
        url: this.widget.url,
        appBar: AppBar(
          elevation: 0,
          title: Text(this.widget.title ?? ''),
          leading: GestureDetector(
            onTap: back,
            child: Image.asset('assets/images/icon_arrow_back_black.png'),
          ),
          actions: <Widget>[
            GestureDetector(
              onTap: () {
                Share.share(this.widget.url);
              },
              child: Image.asset('assets/images/icon_menu_share.png'),
            )
          ],
        ),
        withZoom: true,
        withLocalStorage: true,
        hidden: true,
        initialChild: Container(
          child: const Center(
            child: CupertinoActivityIndicator(),
          ),
        ),
      ),
    );
  }

  Future<bool> _onWillPop () {
    flutterWebviewPlugin.close();
    Navigator.pop(context);
    return Future.value(true);
  }

  // 返回上个页面
  back() {
    print('back');
    flutterWebviewPlugin.close();
    Navigator.pop(context);
  }
}
