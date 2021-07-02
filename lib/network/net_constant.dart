class NetResponseConstant {
  //在这里配置和后端约定好的内容
  static const String data = "data";
  static const String message = "info";
  static const String code = "status";
}

class NetErrorCode {
  //数据成功的code
  static const int SUCCESS = 1;
  //数据转换错误
  static const int PARSE_ERROR = 1006;
  //请求出错
  static const int ERROR = 1002;
}

class NetErrorMsg {
  //数据成功的code
  static const String SUCCESS = "请求成功";
  //数据转换错误
  static const String PARSE_ERROR = "数据解析失败";
  //请求出错
  static const String ERROR = "请求出错,请检查网络后重试";
}

class NetBaseApi {
  static const String BASE_URL = "https://scxs.pysmei.com";

  static const String PROXY = "192.168.62.10:8888";

  static const String IMAGE_BASE_URL = "https://imgapixs.pysmei.com/BookFiles/BookImages";

  static const Map BASE_URL_MAP = {
    "normal" : "https://scxs.pysmei.com",
    "info" : "https://infosxs.pysmei.com",
    "content" : "https://contentxs.pysmei.com",
    "search" : "https://souxs.leeyegy.com/search.aspx/",
    "user" : "https://userxs.pigqq.com"
  };
}
