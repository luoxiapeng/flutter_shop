import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';
import '../Provide/child_category.dart';
import '../service/service_method.dart';
import '../model/category.dart';
import '../model/categoryGoodsList.dart';
import '../provide/category_goods_list.dart';

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
            // 右边小组件
            Column(
              children: <Widget>[
                RightCategoryNav(),
                CategoryGoodsList()
              ],
            )
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
  List list = [];
  var listIndex = 0;
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
          border: Border(right: BorderSide(width: 0.5, color: Colors.black12))),
      child: ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, index) {
          return _leftInkWel(index);
        },
      ),
    );
  }

  Widget _leftInkWel(int index) {
    bool isClick = false;
    isClick = (index == listIndex) ? true : false;
    return InkWell(
      onTap: () {
        setState(() {
          listIndex = index;
        });
        var childList = list[index].bxMallSubDto;
        // var categoryId = list[index].mallCategoryId;
        Provide.value<ChildCategory>(context).getChildCategory(childList);
        // 点击请求接口
        // _getGoodList(categoryId:categoryId);
      },
      child: Container(
        height: ScreenUtil().setHeight(100),
        padding: EdgeInsets.only(left: 10, top: 20),
        decoration: BoxDecoration(
            // 给左侧子类添加背景颜色高亮
            color: isClick ? Color.fromRGBO(236, 238, 239, 1.0) : Colors.white,
            border:Border(bottom: BorderSide(width: 1, color: Colors.black12))
        ),
        child: Text(
          list[index].mallCategoryName,
          style: TextStyle(fontSize: ScreenUtil().setSp(28)),
        ),
      ),
    );
  }

  void _getCategory() async {
    await request('getCategory').then((val) {
      var data = json.decode(val.toString());
      CategoryModel category = CategoryModel.fromJson(data);
      setState(() {
        list = category.data;
        // 默认给第一条数据
        Provide.value<ChildCategory>(context).getChildCategory(list[0].bxMallSubDto);
      });
      print(list[0].bxMallSubDto);
    });
  }
}

//右侧小类类别

class RightCategoryNav extends StatefulWidget {
  _RightCategoryNavState createState() => _RightCategoryNavState();
}

class _RightCategoryNavState extends State<RightCategoryNav> {
  @override
  Widget build(BuildContext context) {
    return Container(
        // child: Text('${childCategory.childCategoryList.length}'),

    child: Provide<ChildCategory>(
      builder: (context, child, childCategory) {
        return Container(
            height: ScreenUtil().setHeight(80),
            width: ScreenUtil().setWidth(570),
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                    bottom: BorderSide(width: 1, color: Colors.black12)
                )
            ),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: childCategory.childCategoryList.length,
              itemBuilder: (context, index) {
                return _rightInkWell(childCategory.childCategoryList[index]);
              },
            ));
      },
    ));
  }

  Widget _rightInkWell(BxMallSubDto item) {
    return InkWell(
      onTap: () {},
      child: Container(
        padding: EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 10.0),
        child: Text(
          item.mallSubName,
          style: TextStyle(fontSize: ScreenUtil().setSp(28)),
        ),
      ),
    );
  }
}


// 商品列表
class CategoryGoodsList extends StatefulWidget {
  CategoryGoodsList({Key key}) : super(key: key);

  _CategoryGoodsListState createState() => _CategoryGoodsListState();
}

class _CategoryGoodsListState extends State<CategoryGoodsList> {
  List list=[];
  @override
  void initState() {
    super.initState();
    _getGoodList();
  }
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        width: ScreenUtil().setWidth(570) ,
        height: ScreenUtil().setHeight(1000),
        child: ListView.builder(
          itemCount: list.length,
          itemBuilder: (context,index){
            return _ListWidget(index);
          },
        )
      ),
    );
  }
  Widget _goodsImage(index){
    return  Container(
      width: ScreenUtil().setWidth(200),
      child: Image.network(list[index].image),
    );

  }
  Widget _goodsName(index){
    return Container( 
      padding: EdgeInsets.all(5.0),
      width: ScreenUtil().setWidth(370),
      child: Text(
        list[index].goodsName,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(fontSize: ScreenUtil().setSp(28)),
        ),
      );
  }
  Widget _goodsPrice(index){
    return  Container( 
      margin: EdgeInsets.only(top:20.0),
      width: ScreenUtil().setWidth(370),
      child:Row(
        children: <Widget>[
            Text(
              '价格:￥${list[index].presentPrice}',
              style: TextStyle(color:Colors.pink,fontSize:ScreenUtil().setSp(30)),
              ),
            Text(
              '￥${list[index].oriPrice}',
              style: TextStyle(
                color: Colors.black26,
                decoration: TextDecoration.lineThrough
              ),
            )
        ]
      )
    );
  }
  Widget _ListWidget(int index){
    return InkWell(
      onTap: (){},
      child: Container(
        padding: EdgeInsets.only(top: 5.0,bottom: 5.0),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(width: 1.0,color: Colors.black12)
          )
        ),
        
        child: Row(
          children: <Widget>[
            _goodsImage(index),
            Column(
              children: <Widget>[
                _goodsName(index),
                _goodsPrice(index)
              ],
            )
          ],
        ),
      )
    );

  }
  void _getGoodList()async {
    var data={
      'categoryId':'4',
      'categorySubId':"",
      'page':1
    };
    await request('getMallGoods',formData:data ).then((val){
        var data = json.decode(val.toString());
        CategoryGoodsListModel goodsList=  CategoryGoodsListModel.fromJson(data);
        setState(() {
         list= goodsList.data;
        });
        print('>>>>>>>>>>>>>>>>>>>:${list[0].goodsName}');
    });

  }

  
}