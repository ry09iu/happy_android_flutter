import 'package:flutter/material.dart';
import 'package:happy_android_flutter/constant/api.dart';
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
}
