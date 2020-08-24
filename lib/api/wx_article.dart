import 'package:flutter/material.dart';
import 'package:happy_android_flutter/constant/api.dart';
import 'package:happy_android_flutter/model/article_list.dart';
import 'package:happy_android_flutter/model/article_list_base.dart';
import 'package:happy_android_flutter/model/wx_article_chapter.dart';
import 'package:happy_android_flutter/util/http_util.dart';

class ApiWxArticle {
  static Future<List<WxArticleChapterModel>> wxArticleChapters(
      {@required BuildContext context, Map<String, dynamic> params}) async {
    var response = await HttpUtil()
        .get(Api.WX_ARTICLE_CHAPTERS, context: context, params: params);
    return response['data'].map<WxArticleChapterModel>((item) {
      return WxArticleChapterModel.fromJson(item);
    }).toList();
  }

  static Future<List<ArticleListModel>> wxArticle(
      {@required BuildContext context,
      int id = 0,
      int page = 1,
      Map<String, dynamic> params}) async {
    var response = await HttpUtil().get(
        Api.WX_ARTICLE_LIST + id.toString() + '/' + page.toString() + '/json',
        context: context,
        params: params);

    ArticleListBaseModel articleList =
        ArticleListBaseModel.fromJson(response['data']);
    return articleList.datas.map<ArticleListModel>((item) {
      return ArticleListModel.fromJson(item);
    }).toList();
  }
}
