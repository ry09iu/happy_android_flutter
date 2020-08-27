import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:happy_android_flutter/api/user.dart';
import 'package:happy_android_flutter/model/user_coin_list.dart';
import 'package:happy_android_flutter/util/screen.dart';
import 'package:happy_android_flutter/util/time.dart';
import 'package:happy_android_flutter/widget/top_clipper.dart';

class CoinPage extends StatefulWidget {
  @override
  _CoinPageState createState() => _CoinPageState();
}

class _CoinPageState extends State<CoinPage> {
  int _page = 1;
  List<UserCoinListModel> _coinList;
  ScrollController _scrollController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController = ScrollController();
    initListData();
  }

  Future<void> initListData() async {
    var list = await ApiUser.userCoinList(context: context, page: _page);
    print(list);
    setState(() {
      _coinList = list;
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    /*if (_coinList == null) {
      return Scaffold(
          appBar: AppBar(
            title: Text('我的积分'),
            elevation: 0,
          ),
          body: Container(
            child: Text('111'),
          ));
    }*/
    return Scaffold(
      appBar: AppBar(
        title: Text('我的积分'),
        elevation: 0,
      ),
      body: _coinList == null
          ? Center(
              child: CupertinoActivityIndicator(),
            )
          : Container(
              child: Column(
                children: [
                  Container(
                    child: Stack(
                      alignment: Alignment.topCenter,
                      children: [
                        topClipperView(height: 320),
                        Container(
                          height: duSetH(320 - Screen.navigationBarHeight),
                          child: Center(
                            child: Text(
                              '66',
                              style: TextStyle(
                                fontSize: duSetSp(124),
                                fontWeight: FontWeight.w400,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.separated(
                        controller: _scrollController,
                        itemCount: _coinList.length,
                        separatorBuilder: (BuildContext context, int index) {
                          return Divider();
                        },
                        itemBuilder: (BuildContext context, int index) {
                          return _buildCoinListItem(_coinList[index]);
                        }),
                  )
                ],
              ),
            ),
    );
  }

  Widget _buildCoinListItem(UserCoinListModel coinData) {
    return Container(
        padding:
            EdgeInsets.symmetric(horizontal: duSetW(60), vertical: duSetH(30)),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  coinData.reason,
                  style: _textStyle(),
                ),
                SizedBox(height: duSetH(20)),
                Text(
                  TimeUtil.convertTime(coinData.date),
                  style: _textStyle(fontSize: 34, textColor: Color(0xFF818181)),
                ),
              ],
            ),
            Spacer(),
            Text(
              '+${coinData.coinCount} 分',
              style: _textStyle(),
            ),
          ],
        ));
  }

  TextStyle _textStyle(
      {double fontSize = 44, Color textColor = const Color(0xFF333333)}) {
    return TextStyle(
      fontSize: duSetSp(fontSize),
      color: textColor,
    );
  }
}
