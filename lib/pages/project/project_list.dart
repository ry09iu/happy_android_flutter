import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:happy_android_flutter/api/project.dart';
import 'package:happy_android_flutter/model/project_list.dart';
import 'package:happy_android_flutter/pages/project/project_item.dart';

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
  List<ProjectListModel> _projectList;
  ScrollController _scrollController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController = ScrollController();
    initListData();
  }

  Future<void> initListData() async {
    var list = await ApiProject.projectList(
        context: context, page: _page, cid: widget.cid);
    print(list);
    setState(() {
      _projectList = list;
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
    super.build(context);
    if (_projectList == null) {
      return Center(
        child: CupertinoActivityIndicator(),
      );
    }
    return Container(
      child: Center(
        child: ListView.builder(
          itemCount: _projectList.length,
          itemBuilder: (BuildContext context, int index) {
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
