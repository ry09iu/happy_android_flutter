import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:happy_android_flutter/constant/app_colors.dart';
import 'package:happy_android_flutter/util/screen.dart';
import 'package:happy_android_flutter/widget/bottom_clipper.dart';
import 'package:happy_android_flutter/widget/input_form.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          ClipPath(
            clipper: BottomClipper(),
            child: Container(
              color: AppColor.primaryColor,
              height: duSetH(600),
            ),
          ),
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
                  },
                style: TextStyle(
                    color: AppColor.primaryColor, fontSize: duSetSp(38)))
          ]),
        ));
  }

  Widget _buildLoginForm() {
    return Positioned(
      width: Screen.width,
      height: duSetH(960),
      top: duSetW(260),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: ShapeDecoration(
            shape: RoundedRectangleBorder(),
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
                hintText: '用户名'),
            inputTextEdit(
                controller: _passwordController,
                keyboardType: TextInputType.visiblePassword,
                prefixIcon: Icons.lock,
                hintText: '密码',
                isPassword: true,
                marginTop: 20),
            SizedBox(height: duSetH(128)),
            _buildLoginButton(),
            _buildFooter(),
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
        child: Text('登录'),
        color: AppColor.primaryColor,
        shape: StadiumBorder(
          side: BorderSide(color: AppColor.primaryColor),
        ),
        textColor: Colors.white,
        onPressed: () {},
      ),
    );
  }

  Widget _buildHeader() {
    return Center(
      child: Column(
        children: [
          Container(
              child: Hero(
            tag: 'loginLogo',
            child: Image.asset(
              'assets/images/login_avator.png',
              width: duSetW(280),
              height: duSetW(280),
              fit: BoxFit.cover,
            ),
          )),
        ],
      ),
    );
  }
}
