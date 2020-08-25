import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('关于'),
        elevation: 0,
      ),
      body: Center(
        child: Text('关于页面'),
      ),
    );
  }
}
