import 'package:happy_android_flutter/constant/sp_key.dart';
import 'package:happy_android_flutter/util/sp_util.dart';

DataTools dataTools = DataTools();

class DataTools {
//设置登录状态
  Future<bool> setLoginState(bool isLogin) async {
    return await spUtil.putBool(SharedPreferencesKeys.LOGIN_STATE_KEY, isLogin);
  }

  ///当前是否已经登录
  Future<bool> isLogin() async {
    return await spUtil.getBool(SharedPreferencesKeys.LOGIN_STATE_KEY);
  }

  //设置登录用户名
  Future<bool> setLoginUserName(String username) async {
    return await spUtil.putString(
        SharedPreferencesKeys.LOGIN_USERNAME_KEY, username);
  }

  ///清除用户名信息
  Future<bool> clearUserName() async {
    return await spUtil.remove(SharedPreferencesKeys.LOGIN_USERNAME_KEY);
  }

  //获取登录用户名
  Future<String> getUserName() async {
    return await spUtil.getString(SharedPreferencesKeys.LOGIN_USERNAME_KEY);
  }
}
