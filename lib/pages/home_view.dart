import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:happy_android_flutter/pages/home/home_page.dart';
import 'package:happy_android_flutter/pages/project/project_page.dart';
import 'package:happy_android_flutter/widget/bottom_navbar.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List<Widget> pageList = List();
  int _currentIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    pageList
      ..add(HomePage())
      ..add(ProjectPage())
      ..add(HomePage())
      ..add(ProjectPage());
    super.initState();
  }

  onTap(index) {
    _currentIndex = index;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return Scaffold(
/*      appBar: AppBar(
        title: Text("玩 Android"),
      ),*/
      body: _body(),
      bottomNavigationBar: BottomNavBar(onTap),
    );
  }

  IndexedStack _body() {
    return IndexedStack(
      children: pageList,
      index: _currentIndex,
    );
  }
}
