import 'package:flutter/material.dart';
import 'package:happy_android_flutter/constant/api.dart';
import 'package:happy_android_flutter/model/article_list.dart';
import 'package:happy_android_flutter/model/article_list_base.dart';
import 'package:happy_android_flutter/model/home_banner.dart';
import 'package:happy_android_flutter/util/http_util.dart';

class ApiHome {
  static Future<List<HomeBannerModel>> homeBanner(
      {@required BuildContext context, Map<String, dynamic> params}) async {
    var response =
        await HttpUtil().get(Api.HOME_BANNER, context: context, params: params);
    return response['data'].map<HomeBannerModel>((item) {
      return HomeBannerModel.fromJson(item);
    }).toList();
  }

  static Future<List<ArticleListModel>> articleTop(
      {@required BuildContext context, Map<String, dynamic> params}) async {
    var response = await HttpUtil()
        .get(Api.HOME_ARTICLE_TOP, context: context, params: params);
    return response['data'].map<ArticleListModel>((item) {
      return ArticleListModel.fromJson(item);
    }).toList();
  }

  static Future<List<ArticleListModel>> articleList(
      {@required BuildContext context,
      int page = 0,
      Map<String, dynamic> params}) async {
    var response = await HttpUtil().get(
        Api.HOME_ARTICLE + page.toString() + '/json',
        context: context,
        params: params);

    ArticleListBaseModel articleList =
        ArticleListBaseModel.fromJson(response['data']);
    return articleList.datas.map<ArticleListModel>((item) {
      return ArticleListModel.fromJson(item);
    }).toList();
  }
}
