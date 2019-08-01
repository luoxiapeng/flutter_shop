import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'dart:convert';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_scree';
import '../service/service_method.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String homePageContent = "开始加载数据.....";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getHomePageContent().then((val) {
      setState(() {
        homePageContent = val.toString();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('百姓生活+'),
        ),
        // 异步回调数据组件
        body: FutureBuilder(
            // 获取异步函数
            future: getHomePageContent(),
            // 获取道上下文以及返回的数据
            builder: (context, snapshot) {
              // 判断数据是否存在
              if (snapshot.hasData) {
                // 将数据进行json转换
                var data = json.decode(snapshot.data.toString());
                // 将数据进行list转换
                List<Map> swiperDataList =
                    (data['data']['slides'] as List).cast(); // 顶部轮播组件数
                return Column(
                  children: <Widget>[SwiperDiy(swiperDataList: swiperDataList)],
                );
              }
            }));
  }
}

// 轮播图组件，使用插件
class SwiperDiy extends StatelessWidget {
  final List swiperDataList;
  // 获取到传递过来的list
  const SwiperDiy({Key key, this.swiperDataList}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // 适配屏幕插件
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334)..init(context);

    return Container(
      // 适配屏幕的宽高
      height: ScreenUtil().setHeight(333),
      width: ScreenUtil().setWidth(750),
      child: Swiper(
        itemBuilder: (BuildContext context, int index) {
          return Image.network(
            "${swiperDataList[index]['image']}",
            fit: BoxFit.fill,
          );
        },
        itemCount: swiperDataList.length,
        pagination: new SwiperPagination(),
        autoplay: true,
      ),
    );
  }
}
