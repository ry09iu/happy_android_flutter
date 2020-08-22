import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:happy_android_flutter/api/home.dart';
import 'package:happy_android_flutter/model/article_list.dart';
import 'package:happy_android_flutter/model/home_banner.dart';
import 'package:happy_android_flutter/pages/home/home_article_list.dart';
import 'package:happy_android_flutter/pages/home/home_banner.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<HomeBannerModel> _banners;
  List<ArticleListModel> _articleTop = List();
  List<ArticleListModel> _articleList;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initHomeData();
  }

  Future<void> initHomeData() async {
    var banners = await ApiHome.homeBanner(context: context);
    var articleTop = await ApiHome.articleTop(context: context);
    var articleList = await ApiHome.articleList(context: context);
    /*print(banners);
    print(articleTop);
    print(articleList);*/
    setState(() {
      _banners = banners;
      _articleTop.addAll(articleTop);
      _articleTop.addAll(articleList);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_banners == null || _articleTop == null) {
      return CupertinoActivityIndicator();
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('首页'),
        elevation: 0,
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            HomeBannerView(_banners),
            Expanded(
              child: HomeArticleListView(_articleTop),
            ),
            /*HomeArticleListView(_articleList),*/
          ],
        ),
      ),
    );
  }
}
