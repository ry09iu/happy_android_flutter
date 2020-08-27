import 'package:flutter/material.dart';
import 'package:happy_android_flutter/constant/app_colors.dart';
import 'package:happy_android_flutter/util/screen.dart';
import 'package:happy_android_flutter/widget/bottom_clipper.dart';

Widget topClipperView({
  double height = 500,
}) {
  return Container(
    child: ClipPath(
      clipper: BottomClipper(),
      child: Container(
        color: AppColor.primaryColor,
        height: duSetH(height),
      ),
    ),
  );
}
