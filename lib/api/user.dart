import 'package:flutter/material.dart';
import 'package:happy_android_flutter/constant/api.dart';
import 'package:happy_android_flutter/model/user_login.dart';
import 'package:happy_android_flutter/util/http_util.dart';

class ApiUser {
  static Future<UserLoginResponseModel> userLogin(
      {@required BuildContext context, Map<String, dynamic> params}) async {
    var response =
        await HttpUtil().post(Api.USER_LOGIN, context: context, params: params);
    return UserLoginResponseModel.fromJson(response['data']);
  }

  static Future<UserLoginResponseModel> userRegister(
      {@required BuildContext context, Map<String, dynamic> params}) async {
    var response = await HttpUtil()
        .post(Api.USER_REGISTER, context: context, params: params);
    return UserLoginResponseModel.fromJson(response['data']);
  }
}
