import 'package:flutter/material.dart';
import 'package:happy_android_flutter/common/application.dart';
import 'package:happy_android_flutter/common/data_tool.dart';
import 'package:happy_android_flutter/constant/api.dart';
import 'package:happy_android_flutter/model/article_list_base.dart';
import 'package:happy_android_flutter/model/user_coin_info.dart';
import 'package:happy_android_flutter/model/user_coin_list.dart';
import 'package:happy_android_flutter/model/user_login.dart';
import 'package:happy_android_flutter/util/http_util.dart';

class ApiUser {
  static Future<UserLoginResponseModel> userLogin(
      {@required BuildContext context, Map<String, dynamic> params}) async {
    var response =
        await HttpUtil().post(Api.USER_LOGIN, context: context, params: params);
    if (response['data'] != null) {
      Application.isLogin = true;
    }
    return UserLoginResponseModel.fromJson(response['data']);
  }

  static Future<UserLoginResponseModel> userRegister(
      {@required BuildContext context, Map<String, dynamic> params}) async {
    var response = await HttpUtil()
        .post(Api.USER_REGISTER, context: context, params: params);
    if (response['data'] != null) {
      Application.isLogin = true;
    }
    return UserLoginResponseModel.fromJson(response['data']);
  }

  static Future<bool> userLogout(
      {@required BuildContext context, Map<String, dynamic> params}) async {
    var response =
        await HttpUtil().get(Api.USER_LOGOUT, context: context, params: params);
    if (response['data'] == null) {
      Application.isLogin = false;
      dataTools.setLoginState(false);
      dataTools.clearUserName();
      dataTools.clearUserID();
      dataTools.clearUserCookie();
      return true;
    }
    return false;
  }

  static Future<List<UserCoinListModel>> userCoinList(
      {@required BuildContext context,
      int page,
      Map<String, dynamic> params}) async {
    var response = await HttpUtil().get(
        Api.USER_COIN_LIST + page.toString() + '/json',
        context: context,
        params: params);
    ArticleListBaseModel list = ArticleListBaseModel.fromJson(response['data']);
    return list.datas.map<UserCoinListModel>((item) {
      return UserCoinListModel.fromJson(item);
    }).toList();
  }

  static Future<UserCoinInfoModel> userCoinInfo(
      {@required BuildContext context, Map<String, dynamic> params}) async {
    var response = await HttpUtil()
        .get(Api.USER_COIN_INFO, context: context, params: params);
    return UserCoinInfoModel.fromJson(response['data']);
  }

  static Future<bool> collectArticle(
      {@required BuildContext context,
      int id,
      Map<String, dynamic> params}) async {
    var response = await HttpUtil().post(
        Api.COLLECT_ARTICLE + id.toString() + '/json',
        context: context,
        params: params);
    if (response['data'] == null) {
      return true;
    }
    return false;
  }

  static Future<bool> unCollectArticle(
      {@required BuildContext context,
      int id,
      Map<String, dynamic> params}) async {
    var response = await HttpUtil().post(
        Api.UNCOLLECT_ARTICLE + id.toString() + '/json',
        context: context,
        params: params);
    if (response['data'] == null) {
      return true;
    }
    return false;
  }
}
