import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import '../Provide/counter.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CartPage extends StatefulWidget {
  CartPage({Key key}) : super(key: key);

  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     body: Center(
       child: Column(
         children: <Widget>[
            Number(),
            MyButton()
         ],
       ),
     ),
    );
  }
}
class Number extends StatelessWidget {
  const Number({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top:200),
      child:Provide<Counter>(
        builder: (context,child,counter){
          return Text(
            '${counter.value}',
            style: TextStyle(fontSize: ScreenUtil().setSp(50)),
          );
        },
      )
    );
  }
}

class MyButton  extends StatelessWidget {
  const MyButton ({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: RaisedButton(
        onPressed: (){
          // 调用状态库的方法
          Provide.value<Counter>(context).increment();
        },
        child: Text(
          '递增'
        ),
      )
    );
  }
}
