import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dingdian/network/net_config.dart';

const _defaultConnectTimeout = Duration.millisecondsPerMinute;
const _defaultSendTimeout = Duration.millisecondsPerMinute;
const _defaultReceiveTimeout = Duration.millisecondsPerMinute;

class NetAppDio with DioMixin implements Dio {
  NetConfig _dioConfig = NetConfig.of();
  NetAppDio._([BaseOptions? options]) {
    options = BaseOptions(
        baseUrl: _dioConfig.baseUrl,
        contentType: Headers.jsonContentType,
        responseType: ResponseType.plain,
        connectTimeout: _defaultConnectTimeout,
        sendTimeout: _defaultSendTimeout,
        receiveTimeout: _defaultReceiveTimeout);

    this.options = options;
    interceptors.addAll(_dioConfig.interceptors);
    httpClientAdapter = DefaultHttpClientAdapter();
  }

  setProxy(String proxy) {
    (httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (client) {
      // config the http client
      client.findProxy = (uri) {
        //proxy all request to localhost:8888
        return "PROXY $proxy";
      };
      // you can also create a HttpClient to dio
      // return HttpClient();
    };
  }

  changeBaserUrl(String baseUrl) {
    this.options.baseUrl = baseUrl;
  }

  static NetAppDio getInstance() => NetAppDio._();
}
