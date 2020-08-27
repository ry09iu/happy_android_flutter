import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:happy_android_flutter/api/user.dart';
import 'package:happy_android_flutter/common/application.dart';
import 'package:happy_android_flutter/common/data_tool.dart';
import 'package:happy_android_flutter/common/navigator.dart';
import 'package:happy_android_flutter/constant/app_colors.dart';
import 'package:happy_android_flutter/pages/user/login_event.dart';
import 'package:happy_android_flutter/pages/user/user_list.dart';
import 'package:happy_android_flutter/pages/user/user_login.dart';
import 'package:happy_android_flutter/util/screen.dart';
import 'package:happy_android_flutter/widget/bottom_clipper.dart';
import 'package:happy_android_flutter/widget/toast.dart';
import 'package:happy_android_flutter/widget/top_clipper.dart';

class UserPage extends StatefulWidget {
  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  String userName;
  String userId;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserName();
    getUserID();
    //监听事件总线上数据变化
    Application.eventBus.on<LoginEvent>().listen((event) {
      if (mounted) {
        setState(() {
          userName = event.username;
          userId = event.id;
        });
      }
    });
  }

  //获取用户名
  void getUserName() async {
    await dataTools.getUserName().then((value) {
      setState(() {
        print("userName = $userName");
        userName = value;
      });
    });
  } //获取用户ID

  void getUserID() async {
    await dataTools.getUserID().then((value) {
      setState(() {
        print("userId = $userId");
        userId = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
                TopClipperView(),
                _buildLogout(),
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
              showLoginPage();
            },
            child: Hero(
              tag: 'loginLogo',
              child: Container(
                width: duSetW(200),
                height: duSetW(200),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFFFFFFFF),
                ),
                child: Center(
                  child: Image.asset(
                    'assets/images/def_avator.png',
                    fit: BoxFit.fitWidth,
                    width: duSetW(140),
                    height: duSetW(100),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: duSetH(40)),
          GestureDetector(
              onTap: () {
                showLoginPage();
              },
              child: Column(
                children: [
                  Text(
                    (userName == null || userName == "") ? "点我登录" : userName,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: duSetSp(50),
                    ),
                  ),
                  SizedBox(height: duSetH(10)),
                  (userId == null || userId == "")
                      ? Container()
                      : Text(
                          "ID：$userId",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: duSetSp(36),
                          ),
                        ),
                ],
              ))
        ],
      ),
    );
  }

  Widget _buildLogout() {
    if (userName == null || userName == '') {
      return Container();
    }
    return Positioned(
      top: 0,
      right: duSetW(48),
      child: GestureDetector(
        onTap: () {
          logout();
        },
        child: Icon(
          Icons.exit_to_app,
          color: Colors.white,
          size: duSetSp(64),
        ),
      ),
    );
  }

  Future<void> logout() async {
    bool result = await ApiUser.userLogout(context: context);
    if (result) {
      showToast(msg: '退出成功');

      setState(() {
        userName = '';
        userId = '';
      });
    }
  }

  void showLoginPage() {
    if (userName == null || userName == "") {
      AppNavigator.push(
          context: context, scene: LoginPage(), isFullScreen: true);
    }
  }
}
