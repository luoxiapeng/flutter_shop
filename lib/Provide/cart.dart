import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class CartProvide with ChangeNotifier{
  
  String cartString="[]";
  save(goodsId,goodsName,count,price,images) async{
    //初始化SharedPreferences
    SharedPreferences prefs = await  SharedPreferences.getInstance();
    cartString=prefs.getString('cartInfo');//获取持久化存储的值
    //判断cartString是否为空，为空说明是第一次添加，或者被key被清除了。
    //如果有值进行decode操作
    var temp=cartString==null?[]:json.decode(cartString.toString());
    
    List<Map> tempList=(temp as List).cast();
     //声明变量，用于判断购物车中是否已经存在此商品ID
    var isHave=false;//默认为没有
    int ival=0;//用于进行循环的索引使用
   //进行循环，找出是否已经存在该商品
    tempList.forEach((item){
      if(item['goodsId']==goodsId){
        tempList[ival]['count']=item['count']+1;
        isHave=true;
      }
      ival++;
    });
     //  如果没有，进行增加
    if(!isHave){
      tempList.add({
        'goodsId':goodsId,
        'goodsName':goodsName,
        'count':count,
        'images':images
      });
    }
    //把字符串进行encode操作，
    cartString=json.encode(tempList).toString();
    print(cartString);
    prefs.setString('cartInfo', cartString);


  }
  remove() async{
     SharedPreferences prefs = await  SharedPreferences.getInstance();
     prefs.remove('cartInfo');
     print('清空完成----------------');
     notifyListeners();
  }

}