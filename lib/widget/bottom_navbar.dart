import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:happy_android_flutter/util/screen.dart';

class BottomNavBar extends StatefulWidget {
  ValueChanged tapCallBack;

  BottomNavBar(this.tapCallBack);

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _currentIndex = 0;
  final List<BottomNavigationBarItem> _navTabs = <BottomNavigationBarItem>[
    BottomNavigationBarItem(
      icon: Icon(Icons.home),
      title: Text('首页'),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.perm_contact_calendar),
      title: Text('项目'),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.account_balance_wallet),
      title: Text('公众号'),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.person),
      title: Text('我的'),
    ),
  ];

  /*final List<BottomNavigationBarItem> _bottomTabs = <BottomNavigationBarItem>[
    BottomNavigationBarItem(
      icon: Icon(Icons.home),
      title: Text('首页'),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.perm_contact_calendar),
      title: Text('项目'),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.account_balance_wallet),
      title: Text('公众号'),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.person),
      title: Text('我的'),
    ),
  ];*/

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Screen.width,
      height: duSetH(200),
      child: BottomNavigationBar(
        selectedItemColor: Colors.redAccent,
        elevation: 5,
        items: _navTabs,
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        onTap: onTap,
      ),
    );
  }

  void onTap(int index) {
    setState(() {
      _currentIndex = index;
      widget.tapCallBack(_currentIndex);
    });
  }
}
