import 'package:flutter/material.dart';
import '../model/category.dart';

//ChangeNotifier的混入是不用管理听众
class ChildCategory with ChangeNotifier{

    List<BxMallSubDto> childCategoryList = [];

    getChildCategory(List<BxMallSubDto> list){
      BxMallSubDto all=BxMallSubDto();
      // 初始化第一个值，因为接口没返回，所以默认给列表添加第一个值为全部
      all.mallSubId='00';
      all.mallCategoryId='00';
      all.mallSubName = '全部';
      all.comments = 'null';
      childCategoryList=[all];
      childCategoryList.addAll(list);
      notifyListeners();
    }
}