import 'package:flutter/material.dart';
import '../model/details.dart';
import '../service/service_method.dart';
import 'dart:convert';

class DetailsInfoProvide with ChangeNotifier{
  DetailsModel goodsInfo =null;


  // Table栏切换
  bool isLeft=true;
  bool isRight=false;


  // 从后台获取数据
  getGoodsInfo(String id) async{
    var formData={'goodId':id,};
    await request('getGoodDetailById',formData:formData).then((val){
       var responseData=json.decode(val.toString());
       print('===================>${responseData}');
       goodsInfo=DetailsModel.fromJson(responseData);
       notifyListeners();
    });
  }
  // Table栏切换
  changeLeftAndRight(String changeState){
    if(changeState =='left'){
      isLeft=true;
      isRight=false;
    }else{
      isLeft=false;
      isRight=true;
    }
    notifyListeners();
  }
}