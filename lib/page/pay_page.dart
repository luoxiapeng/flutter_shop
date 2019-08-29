import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// 页面拆分
import './pay_page/pay_address.dart';
import './pay_page/pay_more.dart';
import './pay_page/pay_goods.dart';
import './pay_page/pay_bottom.dart';


class PayPage extends StatelessWidget {
  const PayPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text('结算明细')
      ),
      body: Stack(
        children: <Widget>[
          ListView(
            children: <Widget>[
              Pay_address(),
              payMore(),
              payGoods()
            ],
          ),
          Positioned(
            bottom: 0,
            left: 0,
            child: payBottom()
          )
        ],
      )
      
     
    );
  }
}