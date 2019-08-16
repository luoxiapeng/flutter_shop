import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';

// 详情页面
import '../page/details_page.dart';

// 获取传递过来的id赋值给goodsId,再将id传递给页面DetailsPage函数就获取到了
Handler detailsHandler=Handler(
  //接收上下文以及，传递的参数格式可以是string或者list
  handlerFunc: (BuildContext context,Map<String,List<String>>params){
    String goodsId=params['id'].first;
    print('index>details goodsID is ${goodsId}');
    return DetailsPage(goodsId); 
  }
);