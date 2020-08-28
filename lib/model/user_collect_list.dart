class UserCollectListModel {
  UserCollectListModel({
    this.author,
    this.chapterId,
    this.chapterName,
    this.courseId,
    this.desc,
    this.envelopePic,
    this.id,
    this.link,
    this.niceDate,
    this.origin,
    this.originId,
    this.publishTime,
    this.title,
    this.userId,
    this.visible,
    this.zan,
  });

  String author;
  int chapterId;
  String chapterName;
  int courseId;
  String desc;
  String envelopePic;
  int id;
  String link;
  String niceDate;
  String origin;
  int originId;
  int publishTime;
  String title;
  int userId;
  int visible;
  int zan;

  factory UserCollectListModel.fromJson(Map<String, dynamic> json) =>
      UserCollectListModel(
        author: json["author"],
        chapterId: json["chapterId"],
        chapterName: json["chapterName"],
        courseId: json["courseId"],
        desc: json["desc"],
        envelopePic: json["envelopePic"],
        id: json["id"],
        link: json["link"],
        niceDate: json["niceDate"],
        origin: json["origin"],
        originId: json["originId"],
        publishTime: json["publishTime"],
        title: json["title"],
        userId: json["userId"],
        visible: json["visible"],
        zan: json["zan"],
      );

  Map<String, dynamic> toJson() => {
        "author": author,
        "chapterId": chapterId,
        "chapterName": chapterName,
        "courseId": courseId,
        "desc": desc,
        "envelopePic": envelopePic,
        "id": id,
        "link": link,
        "niceDate": niceDate,
        "origin": origin,
        "originId": originId,
        "publishTime": publishTime,
        "title": title,
        "userId": userId,
        "visible": visible,
        "zan": zan,
      };
}
