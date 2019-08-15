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

    int page=1;  //列表页数，当改变大类或者小类时进行改变
    String noMoreText=''; //显示更多的标识

    getChildCategory(List<BxMallSubDto> list,String id){
      BxMallSubDto all=BxMallSubDto();
      childIndex=0;
      // 将大类点击的id赋值
      categoryId=id;
       //------------------关键代码start
      page=1;
      noMoreText = ''; 
      //------------------关键代码end
      subId=''; //点击大类时，把子类ID清空
      // 初始化第一个值，因为接口没返回，所以默认给列表添加第一个值为全部
      all.mallSubId='';
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
    addPage(){
      page++;
    }
    //改变noMoreText数据  
    changeNoMore(String text){
      noMoreText=text;
      notifyListeners();
    }
}