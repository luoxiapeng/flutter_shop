import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class payBottom extends StatelessWidget {
  const payBottom({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width:ScreenUtil().setWidth(750),
      color: Colors.white,
      padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
      child: Row(
        children: <Widget>[
          Container(
            width: ScreenUtil().setWidth(555),
            child: Row(
              children: <Widget>[
                Text('应付总额:',style: TextStyle(fontWeight:FontWeight.bold,fontSize: ScreenUtil().setSp(30))),
                Text('￥1288',style: TextStyle(color: Colors.red,fontWeight:FontWeight.bold,fontSize: ScreenUtil().setSp(30))),
              ],
            )
          ),
          
        Container(
            padding: EdgeInsets.fromLTRB(15.0,10.0,15.0,10.0),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(3.0)
            ),
            child: Text('提交订单',style: TextStyle(
              color: Colors.white
            )),
        )
        ],
      ),
    );
  }
}