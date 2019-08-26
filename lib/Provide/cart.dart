import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
    

    //把商品总数量设置为0
    allPrice=0;
    allGoodsCount=0;



   //进行循环，找出是否已经存在该商品
    tempList.forEach((item){
      if(item['goodsId']==goodsId){
        tempList[ival]['count']=item['count']+1;
        cartList[ival].count++;
        isHave=true;
      }
      // 如果为选中就将价格和数量赋值
      if(item['isCheck']){
        allPrice+= (cartList[ival].price* cartList[ival].count);
        allGoodsCount+= cartList[ival].count;
      }
      ival++;
    });
    


     //  如果相同的商品进行增加
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
      
      allPrice+=(count*price);
      allGoodsCount+=count;
    }
    //把字符串进行encode操作，
    cartString=json.encode(tempList).toString();
    print(cartString);
    print(cartList.toString());
    // 加到缓存
    prefs.setString('cartInfo', cartString);
    notifyListeners();


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
      var newItem=item; //赋值数据，再进行修改，flutter不支持直接修改数据
      newItem['isCheck']=isCheck;//改变选中状态
      newList.add(newItem);
    }
    cartString= json.encode(newList).toString();//形成字符串
    prefs.setString('cartInfo', cartString);//进行持久化
    await getCartInfo();
  }
  //购物车加减操作
  addOrReduceAction(var cartItem,String todo) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cartString=prefs.getString('cartInfo');  //得到持久化的字符串
    List<Map> tempList= (json.decode(cartString.toString()) as List).cast();
    int tempIndex =0;
    int changeIndex=0;
    tempList.forEach((item){
         if(item['goodsId']==cartItem.goodsId){
          changeIndex=tempIndex; 
         }
         tempIndex++;
    });
    if(todo=='add'){
      cartItem.count++;
    }else if(cartItem.count==1){
      Fluttertoast.showToast(
          msg: "受不了，商品不能再少了",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIos: 1,
          backgroundColor: Colors.pink,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }else if(cartItem.count>1){
      cartItem.count--;
    }
    tempList[changeIndex]=cartItem.toJson();
    cartString= json.encode(tempList).toString();
    prefs.setString('cartInfo', cartString);//
    await getCartInfo();
    

  }
}