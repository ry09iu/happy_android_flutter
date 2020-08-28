import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:happy_android_flutter/api/user.dart';
import 'package:happy_android_flutter/model/user_collect_list.dart';
import 'package:happy_android_flutter/pages/user/child/favourite_list.dart';
import 'package:happy_android_flutter/util/screen.dart';
import 'package:happy_android_flutter/widget/refresh_more.dart';
import 'package:happy_android_flutter/widget/toast.dart';

class FavouritePage extends StatefulWidget {
  @override
  _FavouritePageState createState() => _FavouritePageState();
}

class _FavouritePageState extends State<FavouritePage> {
  int _page = 0;
  bool _isLoading = false;
  String _loadingText = '加载更多';
  List<UserCollectListModel> _collectList;
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
    var list = await ApiUser.userCollectList(context: context, page: _page);
    print(list);
    setState(() {
      if (loadMore && list.length > 0) {
        _isLoading = false;
        _collectList.addAll(list);
      } else if (list.length == 0) {
        _loadingText = '没有更多';
      } else {
        _collectList = list;
        showToast(msg: '加载完毕');
      }
    });
  }

  Future<void> _pullToRefresh() async {
    _page = 0;
    _collectList.clear();
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
        title: Text('我的收藏'),
        elevation: 0,
      ),
      body: _collectList == null
          ? Center(
              child: CupertinoActivityIndicator(),
            )
          : Container(
              child: RefreshIndicator(
                onRefresh: _pullToRefresh,
                child: Container(
                  child: ListView.builder(
                    controller: _scrollController,
                    itemCount: _collectList.length,
                    itemBuilder: (BuildContext context, int index) {
                      if (index == _collectList.length - 1 && _isLoading) {
                        return refreshLoadMore(text: _loadingText);
                      }
                      return CollectListItemView(article: _collectList[index]);
                    },
                  ),
                ),
              ),
            ),
    );
  }
}
