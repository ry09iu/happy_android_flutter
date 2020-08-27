import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:happy_android_flutter/api/wx_article.dart';
import 'package:happy_android_flutter/constant/app_colors.dart';
import 'package:happy_android_flutter/model/wx_article_chapter.dart';
import 'package:happy_android_flutter/pages/wx_article/wx_article_list.dart';
import 'package:happy_android_flutter/util/screen.dart';

class WxArticlePage extends StatefulWidget {
  @override
  _WxArticlePageState createState() => _WxArticlePageState();
}

class _WxArticlePageState extends State<WxArticlePage> {
  List<WxArticleChapterModel> _wxArticleChapter;
  TabController _tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initTabData();
  }

  Future<void> initTabData() async {
    var chapters = await ApiWxArticle.wxArticleChapters(context: context);
    _tabController =
        TabController(length: chapters.length, vsync: ScrollableState());
    /*print(chapters);*/
    setState(() {
      _wxArticleChapter = chapters;
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_wxArticleChapter == null) {
      return Scaffold(
        appBar: AppBar(
          title: Text('公众号'),
          elevation: 0,
        ),
        body: Center(
          child: CupertinoActivityIndicator(),
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: TabBar(
          tabs: _wxArticleChapter.map((e) {
            return Text(e.name.replaceAll('amp;', ''));
          }).toList(),
          controller: _tabController,
          isScrollable: true,
          indicatorColor: AppColor.primaryColor,
          indicatorSize: TabBarIndicatorSize.label,
          indicatorWeight: duSetW(7),
          labelStyle: TextStyle(
              fontSize: duSetSp(40),
              fontWeight: FontWeight.w700,
              color: AppColor.primaryText),
          labelPadding: EdgeInsets.all(duSetH(25)),
        ),
        automaticallyImplyLeading: false,
        elevation: 0,
      ),
      body: TabBarView(
        controller: _tabController,
        children:
            _wxArticleChapter.map((e) => WxArticleListView(id: e.id)).toList(),
      ),
    );
  }
}
