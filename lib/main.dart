import 'package:flutter/material.dart';
import './page/Index_page.dart';
import 'package:dio/dio.dart';
// 状态库引入
import 'package:provide/provide.dart';
import './Provide/counter.dart';

void main() {
  // 初始化
  var counter =Counter();
  var providers  =Providers();
  //将函数存放在provide,counter发生变化后
   providers
    ..provide(Provider<Counter>.value(counter));
  runApp(ProviderNode(child:MyApp(),providers:providers));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: IndexPage(),
    );
  }

  void getHttp() async {
    try {
      Response response;
      response = await Dio().get(
          "https://www.easy-mock.com/mock/5c60131a4bed3a6342711498/baixing/dabaojian?name=大胸妹");
      return print(response);
    } catch (e) {
      return print(e);
    }
  }
}
