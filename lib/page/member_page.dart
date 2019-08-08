import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import '../Provide/counter.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MemberPage extends StatefulWidget {
  MemberPage({Key key}) : super(key: key);

  _MemberPageState createState() => _MemberPageState();
}

class _MemberPageState extends State<MemberPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     body: Center(
       child: Container(
          margin: EdgeInsets.only(top: 200),
          alignment:Alignment.center,
          child: Provide<Counter>(
            builder: (context,child,counter){
              return Text(
                '${counter.value}',
                style: TextStyle(
                  fontSize: ScreenUtil().setSp(50)
                ),
              );
            },
          ),
      ),
     )
    );
  }
}
