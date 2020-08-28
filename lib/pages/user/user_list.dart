import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:happy_android_flutter/common/navigator.dart';
import 'package:happy_android_flutter/pages/user/child/about_page.dart';
import 'package:happy_android_flutter/pages/user/child/coin_page.dart';
import 'package:happy_android_flutter/pages/user/child/favourite_page.dart';
import 'package:happy_android_flutter/pages/user/child/settings_page.dart';
import 'package:happy_android_flutter/util/screen.dart';

class UserListView extends StatefulWidget {
  @override
  _UserListViewState createState() => _UserListViewState();
}

class _UserListViewState extends State<UserListView> {
  var _userList = [
    {'img': 'assets/images/point.png', 'label': '我的积分', 'key': 'coin'},
    {'img': 'assets/images/favourite.png', 'label': '我的收藏', 'key': 'favourite'},
    /*{'img': 'assets/images/settings.png', 'label': '设置', 'key': 'settings'},*/
    {'img': 'assets/images/about.png', 'label': '关于 APP', 'key': 'about'},
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: _userList.map((item) => _buildListItem(item)).toList(),
    ));
  }

  Widget _buildListItem(var item) {
    return Container(
      padding: EdgeInsets.only(left: duSetW(40), right: duSetW(40)),
      child: ListTileTheme(
        dense: true,
        child: ListTile(
          onTap: () {
            _itemTap(item['key']);
          },
          leading: Container(
            height: duSetW(66),
            width: duSetW(66),
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                    image: AssetImage(item['img']), fit: BoxFit.fill)),
          ),
          title: Text(
            item['label'],
            style: TextStyle(
              fontSize: duSetSp(44),
            ),
          ),
          trailing: Icon(
            Icons.arrow_forward_ios,
            size: duSetSp(40),
            color: Color(0xFFAAAAAA),
          ),
        ),
      ),
    );
  }

  /*Widget _buildListItem(var item) {
    return GestureDetector(
      onTap: () {
        _itemTap(item['key']);
      },
      child: Container(
        padding:
            EdgeInsets.fromLTRB(duSetW(80), duSetH(44), duSetW(80), duSetH(44)),
        decoration: BoxDecoration(
            border: Border(
          bottom: BorderSide(color: Colors.transparent, width: 0.5),
        )),
        child: Row(
          children: [
            Container(
              width: duSetW(60),
              height: duSetW(60),
              child: Image.asset(item['img']),
            ),
            SizedBox(width: duSetW(40)),
            Text(
              item['label'],
              style: TextStyle(fontSize: duSetSp(42)),
            ),
            Spacer(),
            Container(
              child: Icon(
                Icons.arrow_forward_ios,
                size: duSetSp(40),
                color: Color(0xFF616161),
              ),
            )
          ],
        ),
      ),
    );
  }*/

  void _itemTap(String key) {
    switch (key) {
      case 'coin':
        AppNavigator.push(context: context, scene: CoinPage());
        break;
      case 'favourite':
        AppNavigator.push(context: context, scene: FavouritePage());
        break;
      case 'settings':
        AppNavigator.push(context: context, scene: SettingsPage());
        break;
      case 'about':
        AppNavigator.push(context: context, scene: AboutPage());
        break;

      default:
        break;
    }
  }
}
