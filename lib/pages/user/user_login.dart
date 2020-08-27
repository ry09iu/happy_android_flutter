import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:happy_android_flutter/api/user.dart';
import 'package:happy_android_flutter/common/application.dart';
import 'package:happy_android_flutter/common/data_tool.dart';
import 'package:happy_android_flutter/common/navigator.dart';
import 'package:happy_android_flutter/constant/app_colors.dart';
import 'package:happy_android_flutter/model/user_login.dart';
import 'package:happy_android_flutter/pages/user/login_event.dart';
import 'package:happy_android_flutter/pages/user/user_register_page.dart';
import 'package:happy_android_flutter/util/screen.dart';
import 'package:happy_android_flutter/widget/button_progress_indicator.dart';
import 'package:happy_android_flutter/widget/input_form.dart';
import 'package:happy_android_flutter/widget/toast.dart';
import 'package:happy_android_flutter/widget/top_clipper.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isLoading = false;
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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

  Widget _buildFooter() {
    return Container(
        margin: EdgeInsets.only(top: duSetH(44)),
        child: RichText(
          text: TextSpan(children: <InlineSpan>[
            TextSpan(
                text: '没有账号？',
                style:
                    TextStyle(color: Color(0xFF333333), fontSize: duSetSp(38))),
            TextSpan(
                text: '去注册',
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    print('去注册页面');
                    AppNavigator.push(
                        context: context, scene: UserRegisterPage());
                  },
                style: TextStyle(
                    color: AppColor.primaryColor, fontSize: duSetSp(38)))
          ]),
        ));
  }

  Widget _buildLoginForm() {
    return Positioned(
      width: Screen.width,
      /*height: duSetH(960),*/
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
            SizedBox(height: duSetH(100)),
            _buildLoginButton(),
            _buildFooter(),
            SizedBox(height: duSetH(40)),
          ],
        ),
      ),
    );
  }

  Widget _buildLoginButton() {
    return SizedBox(
      width: Screen.width,
      height: duSetH(118),
      child: FlatButton(
        child: isLoading
            ? ButtonProgressIndicator()
            : Text('登录',
                style: TextStyle(
                    letterSpacing: duSetW(10), fontSize: duSetSp(44))),
        color: AppColor.primaryColor,
        shape: StadiumBorder(
          side: BorderSide(color: AppColor.primaryColor),
        ),
        textColor: Colors.white,
        onPressed: () {
          _userLoginSubmit();
        },
      ),
    );
  }

  Future<void> _userLoginSubmit() async {
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

    //收起软键盘
    FocusScope.of(context).requestFocus(FocusNode());
    UserLoginResponseModel userProfile =
        await ApiUser.userLogin(context: context, params: params);
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
      showToast(msg: '登录成功');
      Navigator.of(context).pop();
    }
  }

  void switchLoading() {
    setState(() {
      isLoading = !isLoading;
    });
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
}
