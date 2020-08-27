import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:happy_android_flutter/common/data_tool.dart';
import 'package:happy_android_flutter/constant/api.dart';
import 'package:happy_android_flutter/widget/toast.dart';

class HttpUtil {
  static HttpUtil _instance = HttpUtil._internal();

  factory HttpUtil() => _instance;

  Dio dio;
  CancelToken cancelToken = new CancelToken();

  // 是否启用缓存
  static const CACHE_ENABLE = false;

  HttpUtil._internal() {
    // BaseOptions、Options、RequestOptions 都可以配置参数，优先级别依次递增，且可以根据优先级别覆盖参数
    BaseOptions options = new BaseOptions(
      // 请求基地址,可以包含子路径
      baseUrl: Api.BASE_URL,

      // baseUrl: storage.read(key: STORAGE_KEY_APIURL) ?? SERVICE_API_BASEURL,
      //连接服务器超时时间，单位是毫秒.
      connectTimeout: 10000,

      // 响应流上前后两次接受到数据的间隔，单位为毫秒。
      receiveTimeout: 5000,

      // Http请求头.
      headers: {},

      /// 请求的Content-Type，默认值是"application/json; charset=utf-8".
      /// 如果您想以"application/x-www-form-urlencoded"格式编码请求数据,
      /// 可以设置此选项为 `Headers.formUrlEncodedContentType`,  这样[Dio]
      /// 就会自动编码请求体.
      contentType: 'application/json; charset=utf-8',

      /// [responseType] 表示期望以那种格式(方式)接受响应数据。
      /// 目前 [ResponseType] 接受三种类型 `JSON`, `STREAM`, `PLAIN`.
      ///
      /// 默认值是 `JSON`, 当响应头中content-type为"application/json"时，dio 会自动将响应内容转化为json对象。
      /// 如果想以二进制方式接受响应数据，如下载一个二进制文件，那么可以使用 `STREAM`.
      ///
      /// 如果想以文本(字符串)格式接收响应数据，请使用 `PLAIN`.
      responseType: ResponseType.json,
    );

    dio = new Dio(options);

    // Cookie管理
    /*CookieJar cookieJar = CookieJar();
    dio.interceptors.add(CookieManager(cookieJar));*/

    // 添加拦截器
    dio.interceptors
        .add(InterceptorsWrapper(onRequest: (RequestOptions options) {
      return options; //continue
    }, onResponse: (Response response) {
      return response; // continue
    }, onError: (DioError e) {
      ErrorEntity errorEntity = createErrorEntity(e);
      // 错误提示
      showToast(msg: errorEntity.errorMsg);
      // 错误交互处理
      var context = e.request.extra["context"];
      if (context != null) {
        switch (errorEntity.errorCode) {
          case 401: // 没有权限 重新登录
            /*goLoginPage(context);*/
            break;
          default:
        }
      }
      return errorEntity;
    }));

    /*// 加内存缓存
    dio.interceptors.add(NetCache());

    // 在调试模式下需要抓包调试，所以我们使用代理，并禁用HTTPS证书校验
    if (!Global.isRelease && PROXY_ENABLE) {
      (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
          (client) {
        client.findProxy = (uri) {
          return "PROXY $PROXY_IP:$PROXY_PORT";
        };
        //代理工具会提供一个抓包的自签名证书，会通不过证书校验，所以我们禁用证书校验
        client.badCertificateCallback =
            (X509Certificate cert, String host, int port) => true;
      };
    }*/
  }

  /*
   * Error 统一处理
   */
  // 错误信息
  ErrorEntity createErrorEntity(DioError error) {
    switch (error.type) {
      case DioErrorType.CANCEL:
        {
          return ErrorEntity(errorCode: -1, errorMsg: "请求取消");
        }
        break;
      case DioErrorType.CONNECT_TIMEOUT:
        {
          return ErrorEntity(errorCode: -1, errorMsg: "连接超时");
        }
        break;
      case DioErrorType.SEND_TIMEOUT:
        {
          return ErrorEntity(errorCode: -1, errorMsg: "请求超时");
        }
        break;
      case DioErrorType.RECEIVE_TIMEOUT:
        {
          return ErrorEntity(errorCode: -1, errorMsg: "响应超时");
        }
        break;
      case DioErrorType.RESPONSE:
        {
          try {
            int errCode = error.response.statusCode;
            // String errMsg = error.response.statusMessage;
            // return ErrorEntity(code: errCode, message: errMsg);
            switch (errCode) {
              case 1:
                {
                  return ErrorEntity(errorCode: errCode, errorMsg: "请求超时，请重试");
                }
                break;
              case 400:
                {
                  return ErrorEntity(errorCode: errCode, errorMsg: "请求语法错误");
                }
                break;
              case 401:
                {
                  return ErrorEntity(errorCode: errCode, errorMsg: "没有权限");
                }
                break;
              case 403:
                {
                  return ErrorEntity(errorCode: errCode, errorMsg: "服务器拒绝执行");
                }
                break;
              case 404:
                {
                  return ErrorEntity(errorCode: errCode, errorMsg: "无法连接服务器");
                }
                break;
              case 405:
                {
                  return ErrorEntity(errorCode: errCode, errorMsg: "请求方法被禁止");
                }
                break;
              case 500:
                {
                  return ErrorEntity(errorCode: errCode, errorMsg: "服务器内部错误");
                }
                break;
              case 502:
                {
                  return ErrorEntity(errorCode: errCode, errorMsg: "无效的请求");
                }
                break;
              case 503:
                {
                  return ErrorEntity(errorCode: errCode, errorMsg: "服务器挂了");
                }
                break;
              case 505:
                {
                  return ErrorEntity(
                      errorCode: errCode, errorMsg: "不支持HTTP协议请求");
                }
                break;
              default:
                {
                  // return ErrorEntity(code: errCode, message: "未知错误");
                  return ErrorEntity(
                      errorCode: errCode,
                      errorMsg: error.response.statusMessage);
                }
            }
          } on Exception catch (_) {
            return ErrorEntity(errorCode: -1, errorMsg: "未知错误");
          }
        }
        break;
      default:
        {
          return ErrorEntity(errorCode: -1, errorMsg: error.message);
        }
    }
  }

  /*
   * 取消请求
   *
   * 同一个cancel token 可以用于多个请求，当一个cancel token取消时，所有使用该cancel token的请求都会被取消。
   * 所以参数可选
   */
  void cancelRequests(CancelToken token) {
    token.cancel("cancelled");
  }

  /// 读取本地配置
  Map<String, dynamic> getAuthorizationHeader() {
    var headers;
    /*String accessToken = Global.profile?.accessToken;*/
    String accessToken;
    if (accessToken != null) {
      headers = {
        'Authorization': 'Bearer $accessToken',
      };
    }
    return headers;
  }

  /// restful get 操作
  /// refresh 是否下拉刷新 默认 false
  /// noCache 是否不缓存 默认 true
  /// list 是否列表 默认 false
  /// cacheKey 缓存key
  /// cacheDisk 是否磁盘缓存
  Future get(
    String path, {
    @required BuildContext context,
    Map<String, dynamic> params,
    Options options,
    bool refresh = false,
    bool noCache = !CACHE_ENABLE,
    bool list = false,
    String cacheKey,
    bool cacheDisk = false,
  }) async {
    Options requestOptions = options ?? Options();
    requestOptions = requestOptions.merge(extra: {
      "context": context,
      "refresh": refresh,
      "noCache": noCache,
      "list": list,
      "cacheKey": cacheKey,
      "cacheDisk": cacheDisk,
    });
    Map<String, dynamic> _authorization = getAuthorizationHeader();
    if (_authorization != null) {
      requestOptions = requestOptions.merge(headers: _authorization);
    }

    String cookie = await dataTools.getUserCookie();
    if (cookie != null || cookie != '') {
      requestOptions.headers['Cookie'] = cookie;
    }

    var response = await dio.get(path,
        queryParameters: params,
        options: requestOptions,
        cancelToken: cancelToken);
    return response.data;
  }

  /// restful post 操作
  Future post(
    String path, {
    @required BuildContext context,
    dynamic params,
    Options options,
  }) async {
    Options requestOptions = options ?? Options();
    requestOptions.contentType = 'application/x-www-form-urlencoded';
    requestOptions = requestOptions.merge(extra: {
      "context": context,
    });
    Map<String, dynamic> _authorization = getAuthorizationHeader();
    if (_authorization != null) {
      requestOptions = requestOptions.merge(headers: _authorization);
    }

    String cookie = await dataTools.getUserCookie();
    if (cookie != null || cookie != '') {
      requestOptions.headers['Cookie'] = cookie;
    }

    var response = await dio.post(path,
        data: params, options: requestOptions, cancelToken: cancelToken);
    return response.data;
  }

  /// restful put 操作
  Future put(
    String path, {
    @required BuildContext context,
    dynamic params,
    Options options,
  }) async {
    Options requestOptions = options ?? Options();
    requestOptions = requestOptions.merge(extra: {
      "context": context,
    });
    Map<String, dynamic> _authorization = getAuthorizationHeader();
    if (_authorization != null) {
      requestOptions = requestOptions.merge(headers: _authorization);
    }
    var response = await dio.put(path,
        data: params, options: requestOptions, cancelToken: cancelToken);
    return response.data;
  }

  /// restful patch 操作
  Future patch(
    String path, {
    @required BuildContext context,
    dynamic params,
    Options options,
  }) async {
    Options requestOptions = options ?? Options();
    requestOptions = requestOptions.merge(extra: {
      "context": context,
    });
    Map<String, dynamic> _authorization = getAuthorizationHeader();
    if (_authorization != null) {
      requestOptions = requestOptions.merge(headers: _authorization);
    }
    var response = await dio.patch(path,
        data: params, options: requestOptions, cancelToken: cancelToken);
    return response.data;
  }

  /// restful delete 操作
  Future delete(
    String path, {
    @required BuildContext context,
    dynamic params,
    Options options,
  }) async {
    Options requestOptions = options ?? Options();
    requestOptions = requestOptions.merge(extra: {
      "context": context,
    });
    Map<String, dynamic> _authorization = getAuthorizationHeader();
    if (_authorization != null) {
      requestOptions = requestOptions.merge(headers: _authorization);
    }
    var response = await dio.delete(path,
        data: params, options: requestOptions, cancelToken: cancelToken);
    return response.data;
  }

  /// restful post form 表单提交操作
  Future postForm(
    String path, {
    @required BuildContext context,
    dynamic params,
    Options options,
  }) async {
    Options requestOptions = options ?? Options();
    requestOptions = requestOptions.merge(extra: {
      "context": context,
    });
    Map<String, dynamic> _authorization = getAuthorizationHeader();
    if (_authorization != null) {
      requestOptions = requestOptions.merge(headers: _authorization);
    }
    var response = await dio.post(path,
        data: FormData.fromMap(params),
        options: requestOptions,
        cancelToken: cancelToken);
    return response.data;
  }
}

// 异常处理
class ErrorEntity implements Exception {
  int errorCode;
  String errorMsg;

  ErrorEntity({this.errorCode, this.errorMsg});

  String toString() {
    if (errorMsg == null) return "Exception";
    return "Exception: code $errorCode, $errorMsg";
  }
}
