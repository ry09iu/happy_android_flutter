import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:happy_android_flutter/model/article_list.dart';
import 'package:happy_android_flutter/model/home_banner.dart';
import 'package:happy_android_flutter/pages/home/home_article_item.dart';
import 'package:happy_android_flutter/pages/home/home_banner.dart';
import 'package:happy_android_flutter/util/screen.dart';

class HomeArticleListView extends StatefulWidget {
  final List<HomeBannerModel> banners;
  final List<ArticleListModel> article;
  final String loadingText;
  ValueChanged loadCallBack;

  HomeArticleListView(
      this.banners, this.article, this.loadingText, this.loadCallBack);

  @override
  _HomeArticleListViewState createState() => _HomeArticleListViewState();
}

class _HomeArticleListViewState extends State<HomeArticleListView> {
  int _page = 0;
  bool _isLoading = false;
  ScrollController _scrollController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      var maxScroll = _scrollController.position.maxScrollExtent - duSetH(200);
      var pixels = _scrollController.position.pixels;
      if (pixels >= maxScroll) {
        print('加载更多');
        _page += 1;
        setState(() {
          _isLoading = true;
          widget.loadCallBack(_page);
        });
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.article == null) {
      return Container();
    }
    return Container(
      margin: EdgeInsets.only(top: duSetH(10)),
      child: ListView.builder(
          controller: _scrollController,
          itemCount: widget.article.length,
          itemBuilder: (BuildContext context, int index) {
            if (index == 0) return HomeBannerView(widget.banners);
            if (index == widget.article.length - 1 && _isLoading) {
              return _buildLoadMore();
            }
            return HomeArticleItemView(widget.article[index]);
          }),
    );
  }

  Widget _buildLoadMore() {
    return Container(
      width: Screen.width,
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          widget.loadingText == '没有更多'
              ? Container()
              : CupertinoActivityIndicator(),
          SizedBox(width: 6),
          Text(
            widget.loadingText,
            style: TextStyle(fontSize: 12, color: Color(0xFF666666)),
          )
        ],
      ),
    );
  }
}
