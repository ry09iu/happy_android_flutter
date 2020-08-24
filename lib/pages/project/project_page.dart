import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:happy_android_flutter/api/project.dart';
import 'package:happy_android_flutter/constant/app_colors.dart';
import 'package:happy_android_flutter/model/project_tree.dart';
import 'package:happy_android_flutter/pages/project/project_list.dart';
import 'package:happy_android_flutter/util/screen.dart';

class ProjectPage extends StatefulWidget {
  @override
  _ProjectPageState createState() => _ProjectPageState();
}

class _ProjectPageState extends State<ProjectPage> {
  List<ProjectTreeModel> _proTreeList;
  TabController _tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initTabData();
  }

  Future<void> initTabData() async {
    var trees = await ApiProject.projectTrees(context: context);
    _tabController =
        TabController(length: trees.length, vsync: ScrollableState());
    print(trees);
    setState(() {
      _proTreeList = trees;
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_proTreeList == null) {
      return Scaffold(
        appBar: AppBar(
          title: Text('项目'),
          elevation: 0,
        ),
        body: Center(
          child: CupertinoActivityIndicator(),
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: TabBar(
          tabs: _proTreeList.map((e) {
            return Text(e.name.replaceAll('amp;', ''));
          }).toList(),
          controller: _tabController,
          isScrollable: true,
          indicatorColor: AppColor.primaryColor,
          indicatorSize: TabBarIndicatorSize.label,
          indicatorWeight: duSetW(7),
          labelStyle: TextStyle(
              fontSize: duSetSp(40),
              fontWeight: FontWeight.w700,
              color: AppColor.primaryText),
          labelPadding: EdgeInsets.all(duSetH(25)),
        ),
        automaticallyImplyLeading: false,
        elevation: 0,
      ),
      body: TabBarView(
        controller: _tabController,
        children: _proTreeList.map((e) => ProjectListView(cid: e.id)).toList(),
      ),
    );
  }
}
