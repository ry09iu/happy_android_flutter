class ProjectTreeModel {
  ProjectTreeModel({
    this.children,
    this.courseId,
    this.id,
    this.name,
    this.order,
    this.parentChapterId,
    this.userControlSetTop,
    this.visible,
  });

  List<dynamic> children;
  int courseId;
  int id;
  String name;
  int order;
  int parentChapterId;
  bool userControlSetTop;
  int visible;

  factory ProjectTreeModel.fromJson(Map<String, dynamic> json) =>
      ProjectTreeModel(
        children: List<dynamic>.from(json["children"].map((x) => x)),
        courseId: json["courseId"],
        id: json["id"],
        name: json["name"],
        order: json["order"],
        parentChapterId: json["parentChapterId"],
        userControlSetTop: json["userControlSetTop"],
        visible: json["visible"],
      );

  Map<String, dynamic> toJson() => {
        "children": List<dynamic>.from(children.map((x) => x)),
        "courseId": courseId,
        "id": id,
        "name": name,
        "order": order,
        "parentChapterId": parentChapterId,
        "userControlSetTop": userControlSetTop,
        "visible": visible,
      };
}
