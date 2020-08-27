import 'package:flutter/material.dart';
import 'package:happy_android_flutter/api/user.dart';

class CoinPage extends StatefulWidget {
  @override
  _CoinPageState createState() => _CoinPageState();
}

class _CoinPageState extends State<CoinPage> {
  int _page = 1;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initListData();
  }

  Future<void> initListData() async {
    var list = await ApiUser.userCoinList(context: context, page: _page);
    print(list);
  }

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
