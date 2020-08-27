class UserCoinInfoModel {
  UserCoinInfoModel({
    this.coinCount,
    this.level,
    this.rank,
    this.userId,
    this.username,
  });

  int coinCount;
  int level;
  String rank;
  int userId;
  String username;

  factory UserCoinInfoModel.fromJson(Map<String, dynamic> json) =>
      UserCoinInfoModel(
        coinCount: json["coinCount"],
        level: json["level"],
        rank: json["rank"],
        userId: json["userId"],
        username: json["username"],
      );

  Map<String, dynamic> toJson() => {
        "coinCount": coinCount,
        "level": level,
        "rank": rank,
        "userId": userId,
        "username": username,
      };
}
