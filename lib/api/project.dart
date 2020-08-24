import 'package:flutter/material.dart';
import 'package:happy_android_flutter/constant/api.dart';
import 'package:happy_android_flutter/model/preject_list_base.dart';
import 'package:happy_android_flutter/model/project_list.dart';
import 'package:happy_android_flutter/model/project_tree.dart';
import 'package:happy_android_flutter/util/http_util.dart';

class ApiProject {
  static Future<List<ProjectTreeModel>> projectTrees(
      {@required BuildContext context, Map<String, dynamic> params}) async {
    var response = await HttpUtil()
        .get(Api.PROJECT_TREE, context: context, params: params);
    return response['data'].map<ProjectTreeModel>((item) {
      return ProjectTreeModel.fromJson(item);
    }).toList();
  }

  static Future<List<ProjectListModel>> projectList(
      {@required BuildContext context,
      int page = 1,
      int cid = 0,
      Map<String, dynamic> params}) async {
    var response = await HttpUtil().get(
        Api.PROJECT_LIST + page.toString() + '/json?cid=' + cid.toString(),
        context: context,
        params: params);

    ProjectListBaseModel projectList =
        ProjectListBaseModel.fromJson(response['data']);
    return projectList.datas.map<ProjectListModel>((item) {
      return ProjectListModel.fromJson(item);
    }).toList();
  }
}
