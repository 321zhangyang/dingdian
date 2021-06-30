import 'package:dio/dio.dart';
import 'package:get/get.dart';

//网路基础配置
class NetConfig {
  String? _baseUrl;
  String get baseUrl => _baseUrl!;

  String? _proxy;
  String get proxy => _proxy!;

  List<Interceptor> ?_interceptors;
  List<Interceptor> get interceptors => _interceptors??[];

  init(String baseUrl, {List<Interceptor>? interceptors, String? proxy}) {
    _baseUrl = baseUrl;
    _interceptors = interceptors;
    _proxy = proxy;
  }

  static NetConfig of() => Get.find<NetConfig>();
}
