import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:happy_android_flutter/common/navigator.dart';
import 'package:happy_android_flutter/constant/app_colors.dart';
import 'package:happy_android_flutter/pages/user/user_list.dart';
import 'package:happy_android_flutter/pages/user/user_login.dart';
import 'package:happy_android_flutter/util/screen.dart';
import 'package:happy_android_flutter/widget/bottom_clipper.dart';

class UserPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
/*      appBar: AppBar(
        title: Text('我的'),
        elevation: 0,
      ),*/
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: duSetH(Screen.navigationBarHeight + 60),
              child: Container(
                color: AppColor.primaryColor,
              ),
            ),
            Stack(
              children: [
                ClipPath(
                  clipper: BottomClipper(),
                  child: Container(
                    color: AppColor.primaryColor,
                    height: duSetH(500),
                  ),
                ),
                _buildHeader(context),
              ],
            ),
            UserListView(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Center(
      child: Column(
        children: [
          InkWell(
            onTap: () {
              AppNavigator.push(
                  context: context, scene: LoginPage(), isFullScreen: true);
            },
            child: Hero(
              tag: 'loginLogo',
              child: Container(
                width: duSetW(200),
                height: duSetW(200),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFFE5F1FF),
                ),
                child: Center(
                  child: Image.asset(
                    'assets/images/default_avatar.png',
                    fit: BoxFit.cover,
                    width: duSetW(160),
                    height: duSetW(160),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: duSetH(40)),
          GestureDetector(
            onTap: () {
              AppNavigator.push(
                  context: context, scene: LoginPage(), isFullScreen: true);
            },
            child: Text(
              '点我登录',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: duSetSp(50),
              ),
            ),
          )
        ],
      ),
    );
  }
}
