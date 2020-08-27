import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:happy_android_flutter/api/user.dart';
import 'package:happy_android_flutter/common/application.dart';
import 'package:happy_android_flutter/common/data_tool.dart';
import 'package:happy_android_flutter/constant/app_colors.dart';
import 'package:happy_android_flutter/model/user_login.dart';
import 'package:happy_android_flutter/pages/user/login_event.dart';
import 'package:happy_android_flutter/util/screen.dart';
import 'package:happy_android_flutter/widget/button_progress_indicator.dart';
import 'package:happy_android_flutter/widget/input_form.dart';
import 'package:happy_android_flutter/widget/toast.dart';
import 'package:happy_android_flutter/widget/top_clipper.dart';

class UserRegisterPage extends StatefulWidget {
  @override
  _UserRegisterPageState createState() => _UserRegisterPageState();
}

class _UserRegisterPageState extends State<UserRegisterPage> {
  bool isLoading = false;
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _rePasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          topClipperView(height: 612),
          _buildHeader(),
          _buildLoginForm(),
        ],
      ),
    );
  }

  Widget _buildLoginForm() {
    return Positioned(
      width: Screen.width,
      /*height: duSetH(1044),*/
      top: duSetW(200),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: ShapeDecoration(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(duSetW(10)))),
            color: Colors.white,
            shadows: [
              BoxShadow(
                  color: AppColor.primaryColor.withAlpha(20),
                  offset: Offset(1.0, 1.0),
                  blurRadius: 10.0,
                  spreadRadius: 3.0),
            ]),
        child: Column(
          children: [
            inputTextEdit(
                controller: _usernameController,
                keyboardType: TextInputType.name,
                hintText: '用户名',
                marginTop: 50),
            inputTextEdit(
                controller: _passwordController,
                keyboardType: TextInputType.visiblePassword,
                prefixIcon: Icons.lock,
                hintText: '密码',
                isPassword: true,
                marginTop: 22),
            inputTextEdit(
                controller: _rePasswordController,
                keyboardType: TextInputType.visiblePassword,
                prefixIcon: Icons.lock,
                hintText: '确认密码',
                isPassword: true,
                marginTop: 22),
            SizedBox(height: duSetH(100)),
            _buildLoginButton(),
            SizedBox(height: duSetH(40)),
          ],
        ),
      ),
    );
  }

  Widget _buildLoginButton() {
    return SizedBox(
      width: Screen.width,
      height: duSetH(128),
      child: FlatButton(
        child: isLoading
            ? ButtonProgressIndicator()
            : Text('注册',
                style: TextStyle(
                    letterSpacing: duSetW(10), fontSize: duSetSp(44))),
        color: AppColor.primaryColor,
        shape: StadiumBorder(
          side: BorderSide(color: AppColor.primaryColor),
        ),
        textColor: Colors.white,
        onPressed: () {
          _userRegisterSubmit();
        },
      ),
    );
  }

  void switchLoading() {
    setState(() {
      isLoading = !isLoading;
    });
  }

  Widget _buildHeader() {
    return Center(
      child: Column(
        children: [
          Container(
              child: Hero(
            tag: 'loginLogo',
            child: Image.asset(
              'assets/images/logo_transp.png',
              width: duSetW(320),
              height: duSetW(220),
              fit: BoxFit.fitWidth,
            ),
          )),
        ],
      ),
    );
  }

  Future<void> _userRegisterSubmit() async {
    if (!validInput()) {
      return;
    }

    if (isLoading) {
      showToast(msg: '系统繁忙，请稍后');
      return;
    }

    switchLoading();

    Map<String, dynamic> params = Map();
    params['username'] = _usernameController.value.text;
    params['password'] = _passwordController.value.text;
    params['repassword'] = _rePasswordController.value.text;

    //收起软键盘
    FocusScope.of(context).requestFocus(FocusNode());
    UserLoginResponseModel userProfile =
        await ApiUser.userRegister(context: context, params: params);
    /*print(userProfile);*/
    if (userProfile == null) {
      showToast(msg: '登录失败');
    } else {
      await dataTools.setLoginState(true);
      await dataTools.setLoginUserName(userProfile.username);
      await dataTools.setUserID(userProfile.id);
      await dataTools.setUserCookie("loginUserName=" +
          userProfile.username +
          ";loginUserPassword=" +
          params['password']);

      switchLoading();
      //发送事件
      Application.eventBus
          .fire(LoginEvent(userProfile.username, userProfile.id.toString()));
      showToast(msg: '注册成功');
      Navigator.of(context).pop();
    }
  }

  bool validInput() {
    if (_usernameController.text == null || _usernameController.text == "") {
      showToast(msg: '用户名不能为空');
      return false;
    }
    if (_passwordController.text == null || _passwordController.text == "") {
      showToast(msg: '密码不能为空');
      return false;
    }
    return true;
  }
}
