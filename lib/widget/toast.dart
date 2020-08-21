import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

Future<bool> showToast({
  @required String msg,
  Color backgroundColor = Colors.black38,
  Color textColor = Colors.white,
}) async {
  return await Fluttertoast.showToast(
    msg: msg,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: backgroundColor,
    textColor: textColor,
    fontSize: 16,
  );
}
