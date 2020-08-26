class Api {
  static const String BASE_URL = "https://www.wanandroid.com";

  // 首页 banner
  static const String HOME_BANNER = "/banner/json";

  // 首页置顶文章列表
  static const String HOME_ARTICLE_TOP = "/article/top/json";

  // 首页文章列表 https://www.wanandroid.com/article/list/0/json
  static const String HOME_ARTICLE = "/article/list/";

  // 项目分类
  static const String PROJECT_TREE = "/project/tree/json";

  // 项目列表数据 https://www.wanandroid.com/project/list/1/json?cid=294
  static const String PROJECT_LIST = "/project/list/";

  // 获取公众号列表 https://wanandroid.com/wxarticle/chapters/json
  static const String WX_ARTICLE_CHAPTERS = "/wxarticle/chapters/json";

  // 查看某个公众号历史数据 https://wanandroid.com/wxarticle/list/408/1/json
  // 公众号 ID：拼接在 url 中，eg:408
  // 公众号页码：拼接在 url 中，eg:1
  static const String WX_ARTICLE_LIST = "/wxarticle/list/";

  // 登陆
  static const String USER_LOGIN = "/user/login";

  // 注册
  static const String USER_REGISTER = "/user/register";

  // 退出
  static const String USER_LOGOUT = "/user/logout/json";
}
