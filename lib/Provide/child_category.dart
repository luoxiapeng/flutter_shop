import 'package:flutter/material.dart';
import '../model/category.dart';

//ChangeNotifier的混入是不用管理听众
class ChildCategory with ChangeNotifier{

    List<BxMallSubDto> childCategoryList = [];

    // 酒类别高亮索引
    int childIndex=0;
    // 默认为4的Id为全部
    String categoryId = '4';

    String subId =''; //小类ID 

    getChildCategory(List<BxMallSubDto> list,String id){
      BxMallSubDto all=BxMallSubDto();
      childIndex=0;
      // 将大类点击的id赋值
      categoryId=id;
      subId=''; //点击大类时，把子类ID清空
      // 初始化第一个值，因为接口没返回，所以默认给列表添加第一个值为全部
      all.mallSubId='00';
      all.mallCategoryId='00';
      all.mallSubName = '全部';
      all.comments = 'null';
      childCategoryList=[all];
      childCategoryList.addAll(list);
      notifyListeners();
    }
    //改变子类索引
    changeChildIndex(int index,String id){
       childIndex=index;
       subId=id;
       notifyListeners();
    }
}