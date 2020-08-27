import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:happy_android_flutter/util/screen.dart';

Widget refreshLoadMore({String text = '没有更多'}) {
  return Container(
    width: Screen.width,
    height: duSetH(140),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        text == '没有更多' ? Container() : CupertinoActivityIndicator(),
        SizedBox(width: duSetH(12)),
        Text(
          text,
          style: TextStyle(fontSize: duSetSp(38), color: Color(0xFF666666)),
        )
      ],
    ),
  );
}
