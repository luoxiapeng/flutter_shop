import 'package:flutter/material.dart';
import '../../Provide/details_info.dart';
import 'package:provide/provide.dart';
import '../../Provide/cart.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../Provide/currentIndex.dart';


class DetailsBottom extends StatelessWidget {
 
  @override
  Widget build(BuildContext context) {
    // 获取数据
    var goodsInfo = Provide.value<DetailsInfoProvide>(context).goodsInfo.data.goodInfo;
    var goodsID= goodsInfo.goodsId;
    var goodsName =goodsInfo.goodsName;
    var count =1;
    var price =goodsInfo.presentPrice;
    var images= goodsInfo.image1;

    return Container(
       width:ScreenUtil().setWidth(750),
       color: Colors.white,
       height: ScreenUtil().setHeight(80),
       child: Row(
         children: <Widget>[
           InkWell(
             onTap: (){
                // 跳转到购物车
                Provide.value<CurrentIndexProvide>(context).changeIndex(2);
                Navigator.pop(context);
             },
             child: Container(
                width: ScreenUtil().setWidth(110) ,
                alignment: Alignment.center,
                child:Icon(
                      Icons.shopping_cart,
                      size: 35,
                      color: Colors.red,
                    ), 
              ) ,
           ),
           InkWell(
             onTap: () async{
              await Provide.value<CartProvide>(context).save(goodsID,goodsName,count,price,images);
             },
             child: Container(
               alignment: Alignment.center,
               width: ScreenUtil().setWidth(320),
               height: ScreenUtil().setHeight(80),
               color: Colors.green,
               child: Text(
                 '加入购物车',
                 style: TextStyle(color: Colors.white,fontSize: ScreenUtil().setSp(28)),
               ),
             ) ,
           ),
           InkWell(
             onTap: () async{
               await Provide.value<CartProvide>(context).remove();
             },
             child: Container(
               alignment: Alignment.center,
               width: ScreenUtil().setWidth(320),
               height: ScreenUtil().setHeight(80),
               color: Colors.red,
               child: Text(
                 '马上购买',
                 style: TextStyle(color: Colors.white,fontSize: ScreenUtil().setSp(28)),
               ),
             ) ,
           ),
         ],
       ),
    );
  }
}