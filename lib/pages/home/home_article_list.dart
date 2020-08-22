import 'package:flutter/material.dart';
import 'package:happy_android_flutter/model/article_list.dart';
import 'package:happy_android_flutter/pages/home/home_article_item.dart';
import 'package:happy_android_flutter/util/screen.dart';

class HomeArticleListView extends StatefulWidget {
  final List<ArticleListModel> article;

  HomeArticleListView(this.article);

  @override
  _HomeArticleListViewState createState() => _HomeArticleListViewState();
}

class _HomeArticleListViewState extends State<HomeArticleListView> {
  ScrollController _scrollController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController = ScrollController();
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
    print(widget.article);
    return RefreshIndicator(
      onRefresh: () {
        return null;
      },
      child: Container(
        margin: EdgeInsets.only(top: duSetH(10)),
        child: ListView.builder(
            controller: _scrollController,
            itemCount: widget.article.length,
            itemBuilder: (BuildContext context, int index) {
              return HomeArticleItemView(widget.article[index]);
            }),
      ),
    );
  }
}
