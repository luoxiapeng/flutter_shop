import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class payMore extends StatelessWidget {
  const payMore({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){},
      child: Container(
        width: ScreenUtil().setWidth(750),
        padding: EdgeInsets.fromLTRB(10.0, 10.0, 5.0, 10.0),
        margin: EdgeInsets.only(top:10.0),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(width: 1.0,color: Colors.black12)
          )
        ),
        child: Row(
          children: <Widget>[
            Container(
              alignment: Alignment.centerLeft,
              width: ScreenUtil().setWidth(155),
              child: Text('配送方式'),
            ),
            Container(
              alignment: Alignment.centerRight,
              width: ScreenUtil().setWidth(465),
              child: Text('请选择配送方式'),
            ),
            Container(
              alignment: Alignment.centerRight,
              width: ScreenUtil().setWidth(100),
              child: Icon(Icons.chevron_right),
            )
          ],
        )
      ),
    );
  }
}

