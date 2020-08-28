import 'package:flutter/material.dart';
import 'package:happy_android_flutter/util/screen.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('关于'),
        elevation: 0,
      ),
      body: Container(
        padding:
            EdgeInsets.symmetric(horizontal: duSetW(60), vertical: duSetH(40)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '版本 1.0',
              style:
                  TextStyle(fontSize: duSetSp(50), fontWeight: FontWeight.w600),
            ),
            Text('  - 初始版本发布', style: TextStyle(fontSize: duSetSp(40))),
            Text('  - 本程序 API 接口由 wanandroid 提供，在此表示感谢', style: TextStyle(fontSize: duSetSp(40)))
          ],
        ),
      ),
    );
  }
}
