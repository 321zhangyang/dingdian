import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_dingdian/network/net_constant.dart';
import 'package:flutter_dingdian/network/net_dio.dart';
import 'package:flutter_dingdian/network/net_response.dart';

enum Method {
  get,
  post,
  put,
  delete,
}

class NetUtils {
  NetAppDio _dio = NetAppDio.getInstance();

  Future<dynamic> requestDataFuture<T>(Method method, String url,
      {dynamic params,
      Map<String, dynamic>? queryParameters,
      String? baseUrl,
      bool formatter: true,
      CancelToken? cancelToken}) async {
    String requestMethod = _getMethod(method);
    if (baseUrl != null) {
      _dio.changeBaserUrl(baseUrl);
    }
    NetBaseResponse response = await _request<T>(requestMethod, url,
        data: params,
        queryParameters: queryParameters,
        cancelToken: cancelToken);
    return response;
  }

  Future<NetBaseResponse> _request<T>(
    String method,
    String url, {
    data,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
  }) async {
    _dio.options.method = method;
    try {
      var response = await _dio.request(url,
          data: data,
          queryParameters: queryParameters,
          cancelToken: cancelToken);
      print(response.data.runtimeType);
      try {
        json.decode(response.data);
      } catch (e) {
        print("e ===== e$e");
      }
      try {
        NetBaseResponse baseResponse =
            NetBaseResponse.fromJson(json.decode(response.data));
        return baseResponse;
      } catch (e) {
        print(e);
        return NetBaseResponse(
            NetErrorCode.PARSE_ERROR, NetErrorMsg.PARSE_ERROR, null, false);
      }
    } catch (e) {
      print(e);
      return NetBaseResponse(
          NetErrorCode.ERROR, NetErrorMsg.ERROR, null, false);
    }
  }

  //用于获取当前的请求类型
  String _getMethod(Method method) {
    String netMethod;
    switch (method) {
      case Method.get:
        netMethod = "GET";
        break;
      case Method.post:
        netMethod = "POST";
        break;
      case Method.put:
        netMethod = "PUT";
        break;
      case Method.delete:
        netMethod = "DELETE";
        break;
    }
    return netMethod;
  }
}
