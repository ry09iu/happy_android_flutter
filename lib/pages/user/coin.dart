import 'package:flutter/material.dart';

class CoinPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('我的积分'),
        elevation: 0,
      ),
      body: Center(
        child: Text('我的积分页面'),
      ),
    );
  }
}
