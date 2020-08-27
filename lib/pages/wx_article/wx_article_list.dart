import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:happy_android_flutter/api/project.dart';
import 'package:happy_android_flutter/api/wx_article.dart';
import 'package:happy_android_flutter/model/article_list.dart';
import 'package:happy_android_flutter/model/project_list.dart';
import 'package:happy_android_flutter/model/wx_article_chapter.dart';
import 'package:happy_android_flutter/pages/project/project_item.dart';
import 'package:happy_android_flutter/pages/wx_article/wx_article_item.dart';
import 'package:happy_android_flutter/util/screen.dart';
import 'package:happy_android_flutter/widget/toast.dart';

class WxArticleListView extends StatefulWidget {
  final int id;

  const WxArticleListView({Key key, this.id}) : super(key: key);

  @override
  _WxArticleListViewState createState() => _WxArticleListViewState();
}

class _WxArticleListViewState extends State<WxArticleListView>
    with AutomaticKeepAliveClientMixin {
  int _page = 1;
  bool _isLoading = false;
  String _loadingText = '加载更多';
  List<ArticleListModel> _article;
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
          initListData(true);
        });
      }
    });
    initListData(false);
  }

  Future<void> initListData(bool loadMore) async {
    var list = await ApiWxArticle.wxArticle(
        context: context, id: widget.id, page: _page);
    /*print(list);*/
    setState(() {
      if (loadMore && list.length > 0) {
        _isLoading = false;
        _article.addAll(list);
      } else if (list.length == 0) {
        _loadingText = '没有更多';
      } else {
        _article = list;
        showToast(msg: '刷新完毕');
      }
    });
  }

  Future<void> _pullToRefresh() async {
    _page = 1;
    _article.clear();
    initListData(false);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    if (_article == null) {
      return Center(
        child: CupertinoActivityIndicator(),
      );
    }
    return RefreshIndicator(
      onRefresh: _pullToRefresh,
      child: Container(
        child: ListView.builder(
          controller: _scrollController,
          itemCount: _article.length,
          itemBuilder: (BuildContext context, int index) {
            if (index == _article.length - 1 && _isLoading) {
              return _buildLoadMore();
            }
            return WxArticleItemView(article: _article[index]);
          },
        ),
      ),
    );
  }

  Widget _buildLoadMore() {
    return Container(
      width: Screen.width,
      height: duSetH(140),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          _loadingText == '没有更多' ? Container() : CupertinoActivityIndicator(),
          SizedBox(width: 6),
          Text(
            _loadingText,
            style: TextStyle(fontSize: 12, color: Color(0xFF666666)),
          )
        ],
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
