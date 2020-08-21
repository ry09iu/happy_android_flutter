import 'package:flutter/material.dart';
import 'package:happy_android_flutter/constant/api.dart';
import 'package:happy_android_flutter/model/home_banner.dart';
import 'package:happy_android_flutter/util/http_util.dart';

class ApiHome {
  static Future<List<HomeBannerModel>> getHomeBanner(
      {@required BuildContext context, Map<String, dynamic> params}) async {
    var response =
        await HttpUtil().get(Api.HOME_BANNER, context: context, params: params);
    return response['data'].map<HomeBannerModel>((item) {
      return HomeBannerModel.fromJson(item);
    }).toList();
  }
}
