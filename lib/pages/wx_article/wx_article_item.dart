import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';
import 'package:happy_android_flutter/common/navigator.dart';
import 'package:happy_android_flutter/constant/app_colors.dart';
import 'package:happy_android_flutter/model/article_list.dart';
import 'package:happy_android_flutter/util/screen.dart';
import 'package:happy_android_flutter/util/time.dart';

class WxArticleItemView extends StatelessWidget {
  final ArticleListModel article;

  const WxArticleItemView({Key key, this.article}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          left: duSetW(44),
          top: duSetH(36),
          right: duSetW(44),
          bottom: duSetH(36)),
      decoration: BoxDecoration(
        border:
            Border(bottom: BorderSide(color: Color(0xFFE1E1E1), width: 0.5)),
      ),
      child: GestureDetector(
        onTap: () {
          AppNavigator.pushWeb(context, article.link, article.title);
        },
        child: Column(
          children: <Widget>[
            _buildItemHeader(),
            _buildItemContent(context),
            _buildItemFooter(),
          ],
        ),
      ),
    );
  }

  Widget _buildItemFooter() {
    return Container(
      alignment: Alignment.bottomLeft,
      child: Text(
        article.superChapterName + ' | ' + article.chapterName,
        style: TextStyle(
          color: Color(0xFF212121),
          fontSize: duSetSp(30),
        ),
      ),
    );
  }

  Widget _buildItemContent(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: duSetH(12), bottom: duSetH(12)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            width: Screen.width - duSetW(88),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Html(
                  data: article.title,
                  style: {
                    'body': Style(
                      margin: EdgeInsets.all(0),
                      padding: EdgeInsets.all(0),
                      color: AppColor.primaryText,
                      fontSize: FontSize(duSetSp(40)),
                      fontWeight: FontWeight.w700,
                    ),
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildItemHeader() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(article.author, style: _textStyle()),
          Text(TimeUtil.convertTime(article.publishTime).toString(),
              style: _textStyle()),
        ],
      ),
    );
  }

  TextStyle _textStyle({double size = 30}) {
    return TextStyle(color: Color(0xFF717171), fontSize: duSetSp(size));
  }
}
