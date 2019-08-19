import 'package:flutter/material.dart';
import '../model/details.dart';
import '../service/service_method.dart';
import 'dart:convert';

class DetailsInfoProvide with ChangeNotifier{
  DetailsModel goodsInfo =null;
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
}