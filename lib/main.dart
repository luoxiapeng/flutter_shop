import 'package:flutter/material.dart';
import './page/Index_page.dart';
import 'package:dio/dio.dart';
// 状态库引入
import 'package:provide/provide.dart';
import './Provide/counter.dart';
import './Provide/child_category.dart';
import './Provide/category_goods_list.dart';

void main() {
  var childCategory= ChildCategory();
  var categoryGoodsListProvide= CategoryGoodsListProvide();

  var counter =Counter();
  var providers  =Providers();
  providers
    ..provide(Provider<ChildCategory>.value(childCategory))
    ..provide(Provider<CategoryGoodsListProvide>.value(categoryGoodsListProvide))
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
