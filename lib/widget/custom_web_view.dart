import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:happy_android_flutter/api/user.dart';
import 'package:happy_android_flutter/common/application.dart';
import 'package:happy_android_flutter/util/screen.dart';
import 'package:happy_android_flutter/widget/toast.dart';
import 'package:share/share.dart';

class CustomWebView extends StatefulWidget {
  final String url;
  final String title;
  final int id;
  final bool collect;

  CustomWebView({@required this.url, this.title, this.id, this.collect});

  @override
  _CustomWebViewState createState() => _CustomWebViewState();
}

class _CustomWebViewState extends State<CustomWebView> {
  bool _isCollect = false;
  FlutterWebviewPlugin flutterWebviewPlugin = FlutterWebviewPlugin();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      _isCollect = widget.collect;
    });
  }

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
          title: Text(
            this.widget.title ?? '',
            style: TextStyle(fontSize: duSetSp(44)),
          ),
          leading: GestureDetector(
            onTap: back,
            child: Icon(
              Icons.arrow_back,
              size: duSetSp(64),
            ),
            /*child: Image.asset('assets/images/icon_arrow_back_black.png'),*/
          ),
          actions: <Widget>[
            GestureDetector(
              onTap: () {
                collectArticle();
              },
              child: Container(
                margin: EdgeInsets.only(right: duSetW(60)),
                child: Icon(
                  Icons.favorite,
                  color: _isCollect ? Colors.yellow : Color(0xAAFFFFFF),
                  size: duSetSp(64),
                ),
              ),
              /*child: Image.asset('assets/images/icon_menu_share.png'),*/
            ),
            GestureDetector(
              onTap: () {
                Share.share(this.widget.url);
              },
              child: Container(
                margin: EdgeInsets.only(right: duSetW(60)),
                child: Icon(
                  Icons.share,
                  size: duSetSp(64),
                ),
              ),
              /*child: Image.asset('assets/images/icon_menu_share.png'),*/
            ),
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

  Future<void> collectArticle() async {
    bool result;
    if (!Application.isLogin) {
      showToast(msg: '请先登陆');
      return;
    }
    if (_isCollect) {
      print('取消收藏');
      result = await ApiUser.unCollectArticle(context: context, id: widget.id);
    } else {
      print('收藏');
      result = await ApiUser.collectArticle(context: context, id: widget.id);
    }
    switchCollect(result);
  }

  void switchCollect(bool result) {
    if (result) {
      setState(() {
        _isCollect = !_isCollect;
        _isCollect ? showToast(msg: '收藏成功') : showToast(msg: '取消收藏成功');
      });
    }
  }

  Future<bool> _onWillPop() {
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
