class UserCoinListModel {
  UserCoinListModel({
    this.coinCount,
    this.date,
    this.desc,
    this.id,
    this.reason,
    this.type,
    this.userId,
    this.userName,
  });

  int coinCount;
  int date;
  String desc;
  int id;
  String reason;
  int type;
  int userId;
  String userName;

  factory UserCoinListModel.fromJson(Map<String, dynamic> json) =>
      UserCoinListModel(
        coinCount: json["coinCount"],
        date: json["date"],
        desc: json["desc"],
        id: json["id"],
        reason: json["reason"],
        type: json["type"],
        userId: json["userId"],
        userName: json["userName"],
      );

  Map<String, dynamic> toJson() => {
        "coinCount": coinCount,
        "date": date,
        "desc": desc,
        "id": id,
        "reason": reason,
        "type": type,
        "userId": userId,
        "userName": userName,
      };
}
