import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/cartInfo.dart';

class CartProvide with ChangeNotifier{
  
  String cartString="[]";
  //  计算总价格
   double allPrice= 0;
  //  计算数量
   int allGoodsCount =0;

   bool isAllCheck= true; //是否全选
  // 购物车数据
  List<CartInfoMode> cartList=[];
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
        // tempList[ival]['count']=item['count']+1;
        cartList[ival].count++;
        isHave=true;
      }
      ival++;
    });
     //  如果没有，进行增加
    if(!isHave){
      // tempList.add({
      //   'goodsId':goodsId,
      //   'goodsName':goodsName,
      //   'count':count,
      //   'images':images
      // });
      Map<String,dynamic> newGoods={
         'goodsId':goodsId,
          'goodsName':goodsName,
          'count':count,
          'price':price,
          'images':images,
          'isCheck': true 
      };
      tempList.add(newGoods);
      cartList.add(new CartInfoMode.fromJson(newGoods));
    }
    //把字符串进行encode操作，
    cartString=json.encode(tempList).toString();
    print(cartString);
    print(cartList.toString());
    // 加到缓存
    prefs.setString('cartInfo', cartString);


  }
  //得到购物车中的商品
  getCartInfo() async {
     SharedPreferences prefs = await SharedPreferences.getInstance();
     //获得购物车中的商品,这时候是一个字符串
     cartString=prefs.getString('cartInfo'); 
     //把cartList进行初始化，防止数据混乱 
     cartList=[];
     //判断得到的字符串是否有值，如果不判断会报错
     if(cartString==null){
       cartList=[];
     }else{
       List<Map> tempList= (json.decode(cartString.toString()) as List).cast();
      //  每次进来这个方法要初始化一下总价格和数量
       allPrice=0;
       allGoodsCount=0;
       isAllCheck=true;
       tempList.forEach((item){
          if(item['isCheck']){
             allPrice+=(item['count']*item['price']);
             allGoodsCount+=item['count'];
          }else{
            isAllCheck=false;
          }
          cartList.add(new CartInfoMode.fromJson(item));
       });

     }
      notifyListeners();
  }
  // 删除单个商品功能
  deleteOneGoods(String goodsId) async{
     SharedPreferences prefs = await SharedPreferences.getInstance();
     //获得购物车中的商品,这时候是一个字符串
     cartString=prefs.getString('cartInfo'); 
     
     List<Map> tempList= (json.decode(cartString.toString()) as List).cast();

     int tempIndex=0;
     int delIndex=0;
     tempList.forEach((item){
       if(item['goodsId']==goodsId){
         delIndex=tempIndex;
       }
       tempIndex++;
     });
     tempList.removeAt(delIndex);
     cartString=json.encode(tempList);
      // 加到缓存
     prefs.setString('cartInfo', cartString);
    //  刷新一下接口
     await getCartInfo();

  }
  remove() async{
     SharedPreferences prefs = await  SharedPreferences.getInstance();
     prefs.remove('cartInfo');
     print('清空完成----------------');
     notifyListeners();
  }

  changeCheckState(CartInfoMode cartItem) async{
     SharedPreferences prefs = await SharedPreferences.getInstance();
     cartString=prefs.getString('cartInfo');  //得到持久化的字符串
     List<Map> tempList= (json.decode(cartString.toString()) as List).cast(); //声明临时List，用于循环，找到修改项的索引
     int tempIndex =0;  //循环使用索引
     int changeIndex=0; //需要修改的索引
     tempList.forEach((item){
         
         if(item['goodsId']==cartItem.goodsId){
          //找到索引进行复制
          changeIndex=tempIndex;
         }
         tempIndex++;
     });
     tempList[changeIndex]=cartItem.toJson(); //把对象变成Map值
     cartString= json.encode(tempList).toString(); //变成字符串
     prefs.setString('cartInfo', cartString);//进行持久化
     await getCartInfo();  //重新读取列表
    
  }
  //点击全选按钮操作
  changeAllCheckBtnState(bool isCheck) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cartString=prefs.getString('cartInfo');  //得到持久化的字符串
    List<Map> tempList= (json.decode(cartString.toString()) as List).cast();
    List<Map> newList=[]; //新建一个List，用于组成新的持久化数据。

    // 遍历将所有的项赋值成true
    for(var item in tempList){
      var newItem=item;
      newItem['isCheck']=isCheck;
      newList.add(newItem);
    }
    cartString= json.encode(newList).toString();//形成字符串
    prefs.setString('cartInfo', cartString);//进行持久化
    await getCartInfo();
  }
}