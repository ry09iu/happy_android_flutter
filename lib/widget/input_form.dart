import 'package:flutter/material.dart';
import 'package:happy_android_flutter/constant/app_colors.dart';
import 'package:happy_android_flutter/util/screen.dart';

Widget inputTextEdit({
  @required TextEditingController controller,
  TextInputType keyboardType = TextInputType.text,
  IconData prefixIcon = Icons.person,
  String hintText,
  bool isPassword = false,
  double marginTop = 15,
  bool autofocus = false,
}) {
  return Container(
    margin: EdgeInsets.only(top: duSetH(marginTop)),
    child: TextField(
      autofocus: autofocus,
      controller: controller,
      decoration: InputDecoration(
        prefixIcon: Icon(
          prefixIcon,
          color: AppColor.primaryColor,
          size: duSetSp(66),
        ),
        hintText: hintText,
        hintStyle: TextStyle(fontSize: duSetSp(44), color: Color(0xFFB1B1B1)),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: AppColor.primaryColor),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Color(0xFFEEEEEE), width: 0.5),
        ),
      ),
      style: TextStyle(fontSize: duSetSp(44)),
      keyboardType: keyboardType,
      maxLines: 1,
      autocorrect: false,
      obscureText: isPassword,
    ),
  );
}
