import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:happy_android_flutter/api/user.dart';
import 'package:happy_android_flutter/model/user_coin_info.dart';
import 'package:happy_android_flutter/model/user_coin_list.dart';
import 'package:happy_android_flutter/util/screen.dart';
import 'package:happy_android_flutter/util/time.dart';
import 'package:happy_android_flutter/widget/refresh_more.dart';
import 'package:happy_android_flutter/widget/toast.dart';
import 'package:happy_android_flutter/widget/top_clipper.dart';

class CoinPage extends StatefulWidget {
  @override
  _CoinPageState createState() => _CoinPageState();
}

class _CoinPageState extends State<CoinPage> {
  int _page = 1;
  bool _isLoading = false;
  String _loadingText = '加载更多';
  List<UserCoinListModel> _coinList;
  UserCoinInfoModel _coinInfo;
  ScrollController _scrollController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      var maxScroll = _scrollController.position.maxScrollExtent - duSetH(200);
      var pixels = _scrollController.position.pixels;
      if (pixels >= maxScroll) {
        print('加载更多');
        _page += 1;
        setState(() {
          _isLoading = true;
          initListData(true);
        });
      }
    });
    initListData(false);
  }

  Future<void> initListData(bool loadMore) async {
    var list = await ApiUser.userCoinList(context: context, page: _page);
    var info = await ApiUser.userCoinInfo(context: context);
    print(list);
    print(info);
    setState(() {
      if (loadMore && list.length > 0) {
        _isLoading = false;
        _coinList.addAll(list);
      } else if (list.length == 0) {
        _loadingText = '没有更多';
      } else {
        _coinList = list;
        _coinInfo = info;
        showToast(msg: '加载完毕');
      }
    });
  }

  Future<void> _pullToRefresh() async {
    _page = 1;
    _coinList.clear();
    initListData(false);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                              _coinInfo != null
                                  ? _coinInfo.coinCount.toString()
                                  : '加载中',
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
                  _buildCoinList(),
                ],
              ),
            ),
    );
  }

  Expanded _buildCoinList() {
    return Expanded(
        child: RefreshIndicator(
      onRefresh: _pullToRefresh,
      child: ListView.separated(
          controller: _scrollController,
          itemCount: _coinList.length + 1,
          separatorBuilder: (BuildContext context, int index) {
            return Divider();
          },
          itemBuilder: (BuildContext context, int index) {
            if (index == _coinList.length - 1 && _isLoading) {
              return refreshLoadMore(text: _loadingText);
            }
            if (index == _coinList.length) {
              return refreshLoadMore(text: '没有更多');
            }
            return _buildCoinListItem(_coinList[index]);
          }),
    ));
  }

  Widget _buildCoinListItem(UserCoinListModel coinData) {
    return Container(
        padding:
            EdgeInsets.symmetric(horizontal: duSetW(60), vertical: duSetH(20)),
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
