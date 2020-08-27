import 'package:flutter/material.dart';
import 'package:happy_android_flutter/util/screen.dart';

class ButtonProgressIndicator extends StatelessWidget {
  final double size;
  final Color color;

  ButtonProgressIndicator({this.size: 18, this.color: Colors.white});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: size,
        height: size,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation(color),
        ));
  }
}
