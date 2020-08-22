import 'package:flutter/material.dart';
import 'package:happy_android_flutter/model/article_list.dart';
import 'package:happy_android_flutter/util/screen.dart';

class HomeArticleItemView extends StatelessWidget {
  final ArticleListModel article;

  HomeArticleItemView(this.article);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: duSetW(44), right: duSetW(44)),
      child: Container(
        padding: EdgeInsets.only(top: duSetH(36), bottom: duSetH(36)),
        decoration: BoxDecoration(
          border:
              Border(bottom: BorderSide(color: Color(0xFFE1E1E1), width: 0.5)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _articleItemTop(),
            SizedBox(height: duSetH(35)),
            Text(
              article.title,
              style: TextStyle(
                color: Color(0xFF333333),
                fontSize: duSetSp(40),
                fontWeight: FontWeight.w700,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
            SizedBox(height: duSetH(20)),
            /*Text(article.desc),*/
            _articleItemBottom(),
          ],
        ),
      ),
    );
  }

  Widget _articleItemTop() {
    return Container(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        article.fresh
            ? Row(
                children: <Widget>[
                  Text(
                    '最新',
                    style: TextStyle(color: Colors.blue, fontSize: duSetSp(30)),
                  ),
                  SizedBox(width: duSetW(12)),
                ],
              )
            : Container(),
        Text(
          article.author != '' ? article.author : article.shareUser,
          style: TextStyle(color: Color(0xFF818181), fontSize: duSetSp(30)),
        ),
      ],
    ));
  }

  Widget _articleItemBottom() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        article.type == 1
            ? Row(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.fromLTRB(
                        duSetW(10), duSetH(2), duSetW(10), duSetH(2)),
                    child: Text(
                      '置顶',
                      style: TextStyle(
                          fontSize: duSetSp(24), color: Colors.redAccent),
                    ),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.redAccent),
                        borderRadius: BorderRadius.all(Radius.circular(2))),
                  ),
                  SizedBox(width: duSetW(12)),
                ],
              )
            : Container(),
        Text(article.superChapterName + ' | ', style: _textStyle()),
        Text(article.chapterName, style: _textStyle()),
      ],
    );
  }

  TextStyle _textStyle() {
    return TextStyle(color: Color(0xFF616161), fontSize: duSetSp(30));
  }
}
