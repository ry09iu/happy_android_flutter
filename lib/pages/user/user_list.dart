import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:happy_android_flutter/util/screen.dart';

class UserListView extends StatefulWidget {
  @override
  _UserListViewState createState() => _UserListViewState();
}

class _UserListViewState extends State<UserListView> {
  var _userList = [
    {'img': 'assets/images/point.png', 'label': '我的积分'},
    {'img': 'assets/images/mark.png', 'label': '我的收藏'},
    {'img': 'assets/images/settings.png', 'label': '设置'},
    {'img': 'assets/images/about.png', 'label': '关于'},
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: _userList.map((item) => _buildListItem(item)).toList(),
    ));
  }

  /*Widget _buildListItem(var item) {
    return Container(
      padding: EdgeInsets.only(left: duSetW(40), right: duSetW(40)),
      child: ListTile(
        leading: Container(
          height: duSetW(68),
          width: duSetW(68),
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                  image: AssetImage(item['img']), fit: BoxFit.fill)),
        ),
        title: Text(item['label']),
        trailing: Icon(
          Icons.arrow_forward_ios,
          size: duSetSp(40),
        ),
      ),
    );
  }*/
  Widget _buildListItem(var item) {
    return Container(
      padding:
          EdgeInsets.fromLTRB(duSetW(80), duSetH(44), duSetW(80), duSetH(44)),
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
    );
  }
}
