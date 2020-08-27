import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:happy_android_flutter/api/project.dart';
import 'package:happy_android_flutter/model/project_list.dart';
import 'package:happy_android_flutter/pages/project/project_item.dart';
import 'package:happy_android_flutter/util/screen.dart';
import 'package:happy_android_flutter/widget/refresh_more.dart';
import 'package:happy_android_flutter/widget/toast.dart';

class ProjectListView extends StatefulWidget {
  final int cid;

  const ProjectListView({Key key, this.cid}) : super(key: key);

  @override
  _ProjectListViewState createState() => _ProjectListViewState();
}

class _ProjectListViewState extends State<ProjectListView>
    with AutomaticKeepAliveClientMixin {
  int _page = 1;
  bool _isLoading = false;
  String _loadingText = '加载更多';
  List<ProjectListModel> _projectList;
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
    var list = await ApiProject.projectList(
        context: context, page: _page, cid: widget.cid);
    /*print(list);*/
    setState(() {
      if (loadMore && list.length > 0) {
        _isLoading = false;
        _projectList.addAll(list);
      } else if (list.length == 0) {
        _loadingText = '没有更多';
      } else {
        _projectList = list;
        showToast(msg: '刷新完毕');
      }
    });
  }

  Future<void> _pullToRefresh() async {
    _page = 1;
    _projectList.clear();
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
    super.build(context);
    if (_projectList == null) {
      return Center(
        child: CupertinoActivityIndicator(),
      );
    }
    return RefreshIndicator(
      onRefresh: _pullToRefresh,
      child: Container(
        child: ListView.builder(
          controller: _scrollController,
          itemCount: _projectList.length,
          itemBuilder: (BuildContext context, int index) {
            if (index == _projectList.length - 1 && _isLoading) {
              return refreshLoadMore(text: _loadingText);
            }
            return ProjectItemView(article: _projectList[index]);
          },
        ),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
