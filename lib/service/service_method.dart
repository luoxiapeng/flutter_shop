import 'package:dio/dio.dart';
import 'dart:async';
import 'dart:io';
import '../config/service_url.dart';

Future getHomePageContent() async {
  try {
    Response response;
    Dio dio = new Dio();
    dio.options.contentType =
        ContentType.parse('application/x-www-form-urlencoded');
    var formData = {'lon': '115.02932', 'lat': '35.76189'};
    response = await dio.post(servicePath['homePageContext'], data: formData);
    if (response.statusCode == 200) {
      print(response.data);
      return response.data;
    } else {
      throw Exception('后端接口报错了');
    }
  } catch (e) {
    return print('=========> ${e}');
  }
}
Future getHomePageBeloConten() async {
  try {
    print('开始获取数据...............');
    Response response;
    Dio dio = new Dio();
    dio.options.contentType = ContentType.parse('application/x-www-form-urlencoded');
    int page=1;
    response = await dio.post(servicePath['homePageBelowConten'], data: page);
    if (response.statusCode == 200) {
      print(response.data);
      return response.data;
    } else {
      throw Exception('后端接口报错了');
    }
  } catch (e) {
    return print('=========> ${e}');
  }
}
// 封装请求
Future request(url,{formData}) async {
  try {
    print('开始获取数据...............');
    Response response;
    Dio dio = new Dio();
    dio.options.contentType = ContentType.parse('application/x-www-form-urlencoded');
    // 判断有没有参数
    if(formData == null){
      response = await dio.post(servicePath[url]);
    }else{
      response = await dio.post(servicePath[url], data: formData);
    }
   
    if (response.statusCode == 200) {
      // print(response.data);
      return response.data;
    } else {
      throw Exception('后端接口报错了');
    }
  } catch (e) {
    return print('=========> ${e}');
  }
}