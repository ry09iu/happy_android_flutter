class ArticleListBaseModel {
  ArticleListBaseModel({
    this.curPage,
    this.datas,
    this.offset,
    this.over,
    this.pageCount,
    this.size,
    this.total,
  });

  int curPage;
  List<dynamic> datas;
  int offset;
  bool over;
  int pageCount;
  int size;
  int total;

  factory ArticleListBaseModel.fromJson(Map<String, dynamic> json) =>
      ArticleListBaseModel(
        curPage: json["curPage"],
        datas: List<dynamic>.from(json["datas"].map((x) => x)),
        offset: json["offset"],
        over: json["over"],
        pageCount: json["pageCount"],
        size: json["size"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "curPage": curPage,
        "datas": List<dynamic>.from(datas.map((x) => x)),
        "offset": offset,
        "over": over,
        "pageCount": pageCount,
        "size": size,
        "total": total,
      };
}
