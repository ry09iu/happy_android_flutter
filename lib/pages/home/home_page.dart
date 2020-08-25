import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:happy_android_flutter/api/home.dart';
import 'package:happy_android_flutter/model/article_list.dart';
import 'package:happy_android_flutter/model/home_banner.dart';
import 'package:happy_android_flutter/pages/home/home_article_list.dart';
import 'package:happy_android_flutter/widget/toast.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  String _loadingText = '加载更多';
  List<HomeBannerModel> _banners = List();
  List<ArticleListModel> _articleList = List();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initHomeData();
  }

  Future<void> _pullToRefresh() async {
    _banners.clear();
    _articleList.clear();
    initHomeData();
  }

  Future<void> initHomeData() async {
    var banners = await ApiHome.homeBanner(context: context);
    var articleTop = await ApiHome.articleTop(context: context);
    var articleList = await ApiHome.articleList(context: context);
/*    print(banners);
    print(articleTop);
    print(articleList);*/
    setState(() {
      _banners = banners;
      _articleList.addAll(articleTop);
      _articleList.addAll(articleList);
      showToast(msg: '加载完毕');
    });
  }

  Future<void> _loadMore(page) async {
    var articleList = await ApiHome.articleList(context: context, page: page);
    setState(() {
      if (articleList.length == 0) {
        _loadingText = '没有更多';
      } else {
        _articleList.addAll(articleList);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_banners.length == 0 || _articleList.length == 0) {
      return Scaffold(
        appBar: AppBar(
          title: Text('首页'),
          elevation: 0,
        ),
        backgroundColor: Colors.white,
        body: Center(
          child: CupertinoActivityIndicator(),
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('首页'),
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: RefreshIndicator(
        onRefresh: _pullToRefresh,
        child: HomeArticleListView(
            _banners, _articleList, _loadingText, _loadMore),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
