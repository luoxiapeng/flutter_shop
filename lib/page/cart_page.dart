import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Provide/cart.dart';

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
            return ListView.builder(
               itemCount: cartList.length,
               itemBuilder: (context,index){
                 return ListTile(
                  title: Text(cartList[index].goodsName),
                 );
               },
            );
          }else{
            return Text('${cartList}');
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