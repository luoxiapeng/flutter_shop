import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';
import '../Provide/child_category.dart';
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
            // 右边小组件
            Column(
              children: <Widget>[
                  RightCategoryNav()
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
  List list=[];
  var listIndex=0;
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
    bool isClick=false;
    isClick=(index==listIndex)?true:false;
    return InkWell(
      onTap: (){
        setState(() {
          listIndex=index; 
        });
        // 获取点击时的数据放在状态库
        var childList=list[index].bxMallSubDto;
        Provide.value<ChildCategory>(context).getChildCategory(childList);
      },
      child: Container(
        height: ScreenUtil().setHeight(100),
        padding:EdgeInsets.only(left:10,top:20),
        decoration: BoxDecoration(
          // 给左侧子类添加背景颜色高亮
          color: isClick?Color.fromRGBO(236, 238, 239, 1.0):Colors.white,
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
      builder: (context,child,childCategory){
        return Container(
          height: ScreenUtil().setHeight(80),
          width: ScreenUtil().setWidth(570),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
              bottom: BorderSide(width: 1,color: Colors.black12)
            )
          ),
          child:ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: childCategory.childCategoryList.length,
            itemBuilder: (context,index){
              return _rightInkWell(childCategory.childCategoryList[index]);
            },
          )
        );
      },
    )
  );
}
Widget _rightInkWell(BxMallSubDto item){
    return InkWell(
      onTap: (){},
      child: Container(
        padding:EdgeInsets.fromLTRB(5.0,10.0,5.0,10.0),
        
        child: Text(
          item.mallSubName,
          style: TextStyle(fontSize:ScreenUtil().setSp(28)),
        ),
      ),
    );
  }
}
