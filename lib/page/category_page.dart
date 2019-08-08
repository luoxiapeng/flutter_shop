import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../service/service_method.dart';
import '../model/category.dart';
import 'dart:convert';


class CategoryPage extends StatefulWidget {
  CategoryPage({Key key}) : super(key: key);

  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('商品分类'),
      ),
      body: Container(
        child: Row(
          children: <Widget>[
            LeftCategoryNav(),
          ],
        ),
      ),
    );
  }
}


//左侧导航菜单
class LeftCategoryNav extends StatefulWidget {
  LeftCategoryNav({Key key}) : super(key: key);
  _LeftCategoryNavState createState() => _LeftCategoryNavState();
}

class _LeftCategoryNavState extends State<LeftCategoryNav> {
  List list=[];
  @override
  void initState() { 
    super.initState();
    _getCategory();
  }
  
  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(180),
       decoration: BoxDecoration(
         border: Border(
           right: BorderSide(width: 0.5,color: Colors.black12)
         )
       ),
       child: ListView.builder(
         itemCount: list.length,
         itemBuilder: (context, index) {
           return _leftInkWel(index);
        },
       ),
    );
  }

Widget _leftInkWel(int index){
    return InkWell(
      onTap: (){},
      child: Container(
        height: ScreenUtil().setHeight(100),
        padding:EdgeInsets.only(left:10,top:20),
        decoration: BoxDecoration(
          color: Colors.white,
          border:Border(
            bottom:BorderSide(width: 1,color:Colors.black12)
          )
        ),
        child: Text(list[index].mallCategoryName,style: TextStyle(fontSize:ScreenUtil().setSp(28)),),
      ),
    );
 }
void _getCategory()async{
  await request('getCategory').then((val){
        var data = json.decode(val.toString());
        CategoryModel category= CategoryModel.fromJson(data);
        setState(() {
          list =category.data;
        });
        print(list[0].bxMallSubDto);
    });
  }
}