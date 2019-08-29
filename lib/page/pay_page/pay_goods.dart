import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class payGoods extends StatelessWidget {
  const payGoods({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top:10),
      color: Colors.white,
      child: Column(
        children: <Widget>[
         Title(),
         GoodsItem(),
         allPrice(),
         serveFee(),
         Coupon()
        ],
      ),
    );
  }
  // 标题
  Widget Title(){
    return Container(
      padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
      decoration:BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 1.0,color: Colors.black12)
        )
      ),
      child: Row(
        children: <Widget>[
          Container(
            child: Icon(Icons.account_balance),
          ),
          Container(
            margin: EdgeInsets.only(left: 10.0),
            child: Text('商品明细'),
          )
        ],
      )
    );
  }
  // 商品
  Widget GoodsItem(){
    return Container(
     padding: EdgeInsets.all(10.0),
     width: ScreenUtil().setWidth(750),
     child: Row(
       children: <Widget>[
        //  商品图片
         Container(
           height: ScreenUtil().setHeight(200),
           width: ScreenUtil().setWidth(150),
           child: Image.network('https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1566818292437&di=e215b1119c3a34cb4dc816848e0fc8d5&imgtype=0&src=http%3A%2F%2Fwx1.sinaimg.cn%2Fbmiddle%2F78ed3187ly1fc1kkydec8j205k05kwep.jpg',fit: BoxFit.cover),
         ),
        //  商品信息
         Container(
           margin: EdgeInsets.only(left: 5.0),
           width: ScreenUtil().setWidth(435),
           alignment: Alignment.topLeft,
           child: Column(
             children: <Widget>[
               Container(
                 alignment: Alignment.topLeft,
                 child: Text('法国葡萄酒名酒'),
               ),
               Container(
                 padding: EdgeInsets.all(3.0),
                 alignment: Alignment.topLeft,
                 margin: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 5.0),
                 child: Text('规格:默认'),
               ),
               Container(
                 width: ScreenUtil().setWidth(435),
                 alignment: Alignment.topLeft,
                 child: Row(
                    children: <Widget>[
                      Container(
                        width: ScreenUtil().setWidth(100),
                        
                        child:  Text('￥158',style:TextStyle(color: Colors.red)),
                      ),
                      Container(
                        width: ScreenUtil().setWidth(200),
                        alignment: Alignment.topLeft,
                        child:Text('￥280', style: TextStyle(
                              decoration: TextDecoration.lineThrough
                          )),
                      ),
                      Container(
                        alignment: Alignment.bottomRight,
                        width: ScreenUtil().setWidth(100),
                        child: Text('×1'),
                      )
                    ],
                  ),
               )
             ],
           ),

         )
       ],
     ),

    );
  }
  Widget allPrice(){
    return Container(
     padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
     color: Colors.white,
     child: Row(
       children: <Widget>[
         Expanded(
           flex: 1,
           child: Container(
             child: Text('商品总额'),
             alignment: Alignment.centerLeft,
           ),

         ),
         Expanded(
           flex: 1,
           child: Container(
             child: Text('￥1288',style: TextStyle(color: Colors.red)),
             alignment: Alignment.centerRight
           ),
         )
       ],
     ),
    );
  }
  // 运费
  Widget serveFee(){
    return Container(
     padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
     color: Colors.white,
     child: Row(
       children: <Widget>[
         Expanded(
           flex: 1,
           child: Container(
             child: Text('运费'),
             alignment: Alignment.centerLeft,
           ),

         ),
         Expanded(
           flex: 1,
           child: Container(
             child: Text('+￥0',style: TextStyle(color: Colors.red)),
             alignment: Alignment.centerRight
           ),
         )
       ],
     ),
    );
  }
  // 优惠券
  Widget Coupon(){
    return Container(
     padding: EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 10.0),
     child: Row(
       children: <Widget>[
         Container(
           child: Text('优惠券'),
         ),
         Container(
           width: ScreenUtil().setWidth(600),
           alignment: Alignment.centerRight,
           child: Text('无可用'),
         ),
         Container(
           width: ScreenUtil().setWidth(50),
           child: Icon(Icons.chevron_right),
         )
       ],
     ),
    );
  }
}