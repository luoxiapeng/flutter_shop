import 'package:flutter/material.dart';
import './page/Index_page.dart';
import 'package:dio/dio.dart';
import 'package:fluro/fluro.dart';
// 状态库引入
import 'package:provide/provide.dart';
import './Provide/counter.dart';
import './Provide/child_category.dart';
import './Provide/category_goods_list.dart';
import './Provide/details_info.dart';
import './routers/routes.dart';
import './routers/application.dart';
import './Provide/cart.dart';

void main() {
  
  var childCategory= ChildCategory();
  var categoryGoodsListProvide= CategoryGoodsListProvide();
  var detailsInfoProvide=DetailsInfoProvide();
  var cartProvide = CartProvide();

  var counter =Counter();
  var providers  =Providers();
  providers
    ..provide(Provider<ChildCategory>.value(childCategory))
    ..provide(Provider<CategoryGoodsListProvide>.value(categoryGoodsListProvide))
    ..provide(Provider<DetailsInfoProvide>.value(detailsInfoProvide))
    ..provide(Provider<CartProvide>.value(cartProvide))
    ..provide(Provider<Counter>.value(counter));

  runApp(ProviderNode(child:MyApp(),providers:providers));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // 路由配置
    final router=Router();
    Routes.configureRoutes(router);
    Application.router=router;

    return MaterialApp(
      title: '百姓生活+',
      debugShowCheckedModeBanner: false,
      // 路由配置
      onGenerateRoute: Application.router.generator,
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
