import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../Provide/details_info.dart';
import 'package:flutter_html/flutter_html.dart';



class DetailsWeb  extends StatelessWidget {
  const DetailsWeb ({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var goodsDetail=Provide.value<DetailsInfoProvide>(context).goodsInfo.data.goodInfo.goodsDetail;
    
    return Provide<DetailsInfoProvide>(
       builder: (context,child,val){
         var isLeft=Provide.value<DetailsInfoProvide>(context).isLeft;
         if(isLeft){
          return Container(
            child: Html(
              data:goodsDetail,
            ),
          );
         }else{
           return Container(
              alignment: Alignment.center,
              width: ScreenUtil().setWidth(750),
              padding: EdgeInsets.all(10),
              child: Text('暂无数据......'),
            );
         }
       },
    );
    
    
  }
}