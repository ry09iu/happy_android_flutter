import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:happy_android_flutter/constant/app_colors.dart';
import 'package:happy_android_flutter/util/screen.dart';
import 'package:happy_android_flutter/widget/bottom_clipper.dart';
import 'package:happy_android_flutter/widget/input_form.dart';

class UserRegisterPage extends StatefulWidget {
  @override
  _UserRegisterPageState createState() => _UserRegisterPageState();
}

class _UserRegisterPageState extends State<UserRegisterPage> {
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
          ClipPath(
            clipper: BottomClipper(),
            child: Container(
              color: AppColor.primaryColor,
              height: duSetH(612),
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
      height: duSetH(1044),
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
                hintText: '用户名'),
            inputTextEdit(
                controller: _passwordController,
                keyboardType: TextInputType.visiblePassword,
                prefixIcon: Icons.lock,
                hintText: '密码',
                isPassword: true,
                marginTop: 20),
            inputTextEdit(
                controller: _rePasswordController,
                keyboardType: TextInputType.visiblePassword,
                prefixIcon: Icons.lock,
                hintText: '确认密码',
                isPassword: true,
                marginTop: 20),
            SizedBox(height: duSetH(128)),
            _buildLoginButton(),
            /*_buildFooter(),*/
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
        child: Text(
          '注册',
          style: TextStyle(letterSpacing: duSetW(10)),
        ),
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
