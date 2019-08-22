import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Provide/cart.dart';

// 页面拆分
import './cart_page/cart_item.dart';
import './cart_page/cart_bottom.dart';

class CartPage extends StatefulWidget {
  CartPage({Key key}) : super(key: key);

  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {

  List<String> testList =[];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('购物车'),
      ),
      body: FutureBuilder(
        future: _getCartInfo(context),
        builder: (context,snapshot){
          List cartList=Provide.value<CartProvide>(context).cartList;
          if(snapshot.hasData){
            print('--------------${cartList}');
            return Stack(
              children: <Widget>[
                Container(
                 margin: EdgeInsets.only(bottom: 50.0),
                 child: ListView.builder(
                    itemCount: cartList.length,
                    itemBuilder: (context,index){
                      return CartItem(cartList[index]);
                    },
                  ),
                ),
                Positioned(
                  bottom: -5,
                  left: 0,
                  child:CartBottom(),
                )
              ],
              
            );
            
            
          }else{
            return Text('加载中.....');
          }
        },
      ),
    );
  }
  Future<String> _getCartInfo(BuildContext context) async{
     await Provide.value<CartProvide>(context).getCartInfo();
     return 'end';
  }

  
}