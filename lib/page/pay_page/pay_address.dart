import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Pay_address extends StatelessWidget {
  const Pay_address({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){},
      child: Container(
        padding: EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 10.0),
        width: ScreenUtil().setWidth(750),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(width: 1.0,color: Colors.black12)
          )
        ),
        child: Row(
          children: <Widget>[
            // 图标
            Container(
              width: ScreenUtil().setWidth(160),
              child: Icon(Icons.edit_location,size: ScreenUtil().setSp(50.0),color: Colors.pink),
            ),
            // 地址
            Container(
              width: ScreenUtil().setHeight(550),
              child: Column(
                children: <Widget>[
                  Container(
                    alignment: Alignment.topLeft,
                    child: Row(
                      children: <Widget>[
                        Text('小螺号'),
                        Text('13480333085')
                      ],
                    ),
                  ),
                  Container(
                    alignment: Alignment.bottomLeft,
                    width: ScreenUtil().setHeight(550),
                    margin: EdgeInsets.only(top: 10.0),
                    child: Text(
                    '广州市天河区珠江新城',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis
                    ),
                  )
                ],
              ),
            ),
            // 图标
            Container(
              alignment: Alignment.centerRight,
              width: ScreenUtil().setWidth(50),
              child: Icon(Icons.chevron_right)

            )
          ],
        ),
        
      ),
    );
  }
}

// class Pay_address extends StatelessWidget {
//   const Pay_address({Key key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Text('哈哈哈'),
//     );
//   }
// }