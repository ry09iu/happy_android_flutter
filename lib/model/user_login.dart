class UserLoginResponseModel {
  UserLoginResponseModel({
    this.admin,
    this.chapterTops,
    this.coinCount,
    this.collectIds,
    this.email,
    this.icon,
    this.id,
    this.nickname,
    this.password,
    this.publicName,
    this.token,
    this.type,
    this.username,
  });

  bool admin;
  List<dynamic> chapterTops;
  int coinCount;
  List<dynamic> collectIds;
  String email;
  String icon;
  int id;
  String nickname;
  String password;
  String publicName;
  String token;
  int type;
  String username;

  factory UserLoginResponseModel.fromJson(Map<String, dynamic> json) =>
      UserLoginResponseModel(
        admin: json["admin"],
        chapterTops: List<dynamic>.from(json["chapterTops"].map((x) => x)),
        coinCount: json["coinCount"],
        collectIds: List<dynamic>.from(json["collectIds"].map((x) => x)),
        email: json["email"],
        icon: json["icon"],
        id: json["id"],
        nickname: json["nickname"],
        password: json["password"],
        publicName: json["publicName"],
        token: json["token"],
        type: json["type"],
        username: json["username"],
      );

  Map<String, dynamic> toJson() => {
        "admin": admin,
        "chapterTops": List<dynamic>.from(chapterTops.map((x) => x)),
        "coinCount": coinCount,
        "collectIds": List<dynamic>.from(collectIds.map((x) => x)),
        "email": email,
        "icon": icon,
        "id": id,
        "nickname": nickname,
        "password": password,
        "publicName": publicName,
        "token": token,
        "type": type,
        "username": username,
      };
}

class UserLoginRequestModel {
  UserLoginRequestModel({
    this.password,
    this.username,
  });

  String password;
  String username;

  factory UserLoginRequestModel.fromJson(Map<String, dynamic> json) =>
      UserLoginRequestModel(
        password: json["password"],
        username: json["username"],
      );

  Map<String, dynamic> toJson() => {
        "password": password,
        "username": username,
      };
}
