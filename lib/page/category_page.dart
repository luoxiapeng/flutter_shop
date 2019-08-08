import 'package:flutter/material.dart';
import '../service/service_method.dart';
import '../model/category.dart';
import 'dart:convert';


class CategoryPage extends StatefulWidget {
  CategoryPage({Key key}) : super(key: key);

  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {

  void _CategoryPageData() async{
    await request('getCategory').then((val){
      var data=json.decode(val.toString());
      // 数据模型的方式
      CategoryBigListModel list=CategoryBigListModel.formJson(data['data']);
      list.data.forEach((item){
        print(item.mallCategoryName);
      });
    });
  }
  @override
  void initState() {
    _CategoryPageData();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
       child: Text('分类'),
    );
  }
}
