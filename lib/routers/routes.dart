import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import './rotuer_handler.dart';

class Routes{
  static String root='/';
  // 定义跳转的链接
  static String detailsPage='/detail';
  static void configureRoutes(Router router){
    router.notFoundHandler=new Handler(
      // 跳转报错的时候可以写一个404页面在这里提示用户
       handlerFunc: (BuildContext context,Map<String,List<String>>params){
         print('ERROR====>ROUTE WAS NOT FONUND!!!');
       }
    );
    // 接收详情页面的Handler
    router.define(detailsPage,handler: detailsHandler);
  }
}