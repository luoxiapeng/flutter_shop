import 'package:demo/Provide/child_category.dart';
import 'package:demo/Provide/currentIndex.dart';
import 'package:demo/model/category.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
// import 'package:flutter_scree';
import '../service/service_method.dart';
import '../routers/application.dart';
import 'package:provide/provide.dart';
import '../Provide/child_category.dart';
import '../model/category.dart';

import './home_page/home_searchBarDelegate.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  String homePageContent = "开始加载数据.....";
  int page = 1;
  List<Map> hotGoodsList = [];

  // 保持页面状态重写
  @override
  bool get wantKeepAlive => true;
  @override
  void initState() {
    _getHotGoods();
    super.initState();
  }

  GlobalKey _footerKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    var formData = {'lon': '115.02932', 'lat': '35.76189'};
    return Scaffold(
        appBar: AppBar(title: Text('百姓生活+'), actions: <Widget>[
          IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                print('开始搜索');
                showSearch(context: context, delegate: searchBarDelegate());
              }),
        ]),
        // 异步回调数据组件
        body: FutureBuilder(
            // 获取异步函数
            future: request('homePageContext', formData: formData),
            // 获取道上下文以及返回的数据
            builder: (context, snapshot) {
              // 判断数据是否存在
              if (snapshot.hasData) {
                // 将数据进行json转换
                var data = json.decode(snapshot.data.toString());
                // 将数据进行list转换
                List<Map> swiperDataList =
                    (data['data']['slides'] as List).cast(); // 顶部轮播组件数

                // 导航栏数据
                List<Map> navigatorList =
                    (data['data']['category'] as List).cast();
                // 删除多余的数据
                if (navigatorList.length > 10) {
                  navigatorList.removeRange(10, navigatorList.length);
                }

                // 广告栏
                String advertesPicture =
                    data['data']['advertesPicture']['PICTURE_ADDRESS'];
                // 拨打电话
                String leaderImage = data['data']['shopInfo']['leaderImage'];
                String leaderPhone = data['data']['shopInfo']['leaderPhone'];

                // 获取商品推荐数据
                List<Map> recommendList =
                    (data['data']['recommend'] as List).cast();

                //获取楼层数据
                String floor1Title =
                    data['data']['floor1Pic']['PICTURE_ADDRESS'];
                String floor2Title =
                    data['data']['floor2Pic']['PICTURE_ADDRESS'];
                String floor3Title =
                    data['data']['floor3Pic']['PICTURE_ADDRESS'];
                List<Map> floor1 =
                    (data['data']['floor1'] as List).cast(); //楼层1商品图片
                List<Map> floor2 =
                    (data['data']['floor2'] as List).cast(); //楼层2商品图片
                List<Map> floor3 =
                    (data['data']['floor3'] as List).cast(); //楼层3商品图片

                return EasyRefresh(
                    footer: ClassicalFooter(
                      key: _footerKey,
                      bgColor: Colors.white,
                      textColor: Colors.pink,
                      infoColor: Colors.pink,
                      showInfo: true,
                      noMoreText: '没有更多数据了',
                      loadText: '加载中',
                      loadReadyText: '上拉加载....',
                    ),
                    child: ListView(
                      children: <Widget>[
                        SwiperDiy(swiperDataList: swiperDataList),
                        TopNavigator(navigatorList: navigatorList),
                        AdBanner(advertesPicture: advertesPicture),
                        LeaderPhone(
                            leaderImage: leaderImage, leaderPhone: leaderPhone),
                        Recommend(recommendList: recommendList),
                        FloorTitle(picture_address: floor1Title),
                        FloorContent(floorGoodsList: floor1),
                        FloorTitle(picture_address: floor2Title),
                        FloorContent(floorGoodsList: floor2),
                        FloorTitle(picture_address: floor3Title),
                        FloorContent(floorGoodsList: floor3),
                        _hotGoods()
                      ],
                    ),
                    onLoad: () async {
                      print('开始加载更多');
                      var formPage = {'page': page};
                      await request('homePageBelowConten', formData: formPage)
                          .then((val) {
                        var data = json.decode(val.toString());
                        List<Map> newGoodsList = (data['data'] as List).cast();
                        setState(() {
                          hotGoodsList.addAll(newGoodsList);
                          page++;
                        });
                      });
                      //  await _getHotGoods();
                    });
              } else {
                return Center(
                  child: Text('加载中......'),
                );
              }
            }));
  }

  void _getHotGoods() {
    var formPage = {'page': page};
    request('homePageBelowConten', formData: formPage).then((val) {
      var data = json.decode(val.toString());
      List<Map> newGoodsList = (data['data'] as List).cast();
      setState(() {
        hotGoodsList.addAll(newGoodsList);
        page++;
      });
    });
  }

  Widget hotTitle = Container(
    margin: EdgeInsets.only(top: 10.0),
    padding: EdgeInsets.all(5.0),
    alignment: Alignment.center,
    decoration: BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(width: 0.5, color: Colors.black12))),
    child: Text('火爆专区'),
  );
  Widget _wrapList() {
    if (hotGoodsList.length != 0) {
      List<Widget> listWidget = hotGoodsList.map((val) {
        return InkWell(
            onTap: () {
              Application.router
                  .navigateTo(context, "/detail?id=${val['goodsId']}");
            },
            child: Container(
              width: ScreenUtil().setWidth(372),
              color: Colors.white,
              padding: EdgeInsets.all(5.0),
              margin: EdgeInsets.only(bottom: 3.0),
              child: Column(
                children: <Widget>[
                  Image.network(
                    val['image'],
                    width: ScreenUtil().setWidth(375),
                  ),
                  Text(
                    val['name'],
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: Colors.pink, fontSize: ScreenUtil().setSp(26)),
                  ),
                  Row(
                    children: <Widget>[
                      Text('￥${val['mallPrice']}'),
                      Text(
                        '￥${val['price']}',
                        style: TextStyle(
                            color: Colors.black26,
                            decoration: TextDecoration.lineThrough),
                      )
                    ],
                  )
                ],
              ),
            ));
      }).toList();

      return Wrap(
        spacing: 2,
        children: listWidget,
      );
    } else {
      return Text(' ');
    }
  }

  Widget _hotGoods() {
    return Container(
        child: Column(
      children: <Widget>[
        hotTitle,
        _wrapList(),
      ],
    ));
  }
}

// 轮播图组件，使用插件
class SwiperDiy extends StatelessWidget {
  final List swiperDataList;
  // 获取到传递过来的list
  const SwiperDiy({Key key, this.swiperDataList}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      // 适配屏幕的宽高
      height: ScreenUtil().setHeight(333),
      width: ScreenUtil().setWidth(750),
      child: Swiper(
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: () {
              Application.router.navigateTo(
                  context, "/detail?id=${swiperDataList[index]['goodsId']}");
            },
            child: Image.network(
              "${swiperDataList[index]['image']}",
              fit: BoxFit.fill,
            ),
          );
        },
        itemCount: swiperDataList.length,
        pagination: new SwiperPagination(),
        autoplay: true,
      ),
    );
  }
}

// 导航栏组件
class TopNavigator extends StatelessWidget {
  final List navigatorList;
  const TopNavigator({Key key, this.navigatorList}) : super(key: key);

  Widget _gridViewItemUI(BuildContext context, item, index) {
    return InkWell(
      onTap: () {
        _goCategory(context, index, item['mallCategoryId']);
      },
      child: Column(
        children: <Widget>[
          Image.network(
            item['image'],
            width: ScreenUtil().setWidth(95),
          ),
          Text(item['mallCategoryName'])
        ],
      ),
    );
  }

  void _goCategory(context, int index, String categroyId) async {
    await request('getCategory').then((val) {
      var data = json.decode(val.toString());
      CategoryModel category = CategoryModel.fromJson(data);
      List list = category.data;
      Provide.value<ChildCategory>(context).changeCategory(categroyId, index);
      Provide.value<ChildCategory>(context)
          .getChildCategory(list[index].bxMallSubDto, categroyId);
      Provide.value<CurrentIndexProvide>(context).changeIndex(1);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (navigatorList.length > 10) {
      navigatorList.removeRange(10, navigatorList.length);
    }
    var tempIndex = -1;
    return Container(
      height: ScreenUtil().setHeight(320),
      padding: EdgeInsets.all(3.0),
      child: GridView.count(
          crossAxisCount: 5,
          physics: NeverScrollableScrollPhysics(),
          padding: EdgeInsets.all(3.0),
          children: navigatorList.map((item) {
            tempIndex++;
            return _gridViewItemUI(context, item, tempIndex);
          }).toList()),
    );
  }
}

// 广告栏
class AdBanner extends StatelessWidget {
  final String advertesPicture;
  const AdBanner({Key key, this.advertesPicture}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(child: Image.network(advertesPicture));
  }
}

// 拨打电话组件
class LeaderPhone extends StatelessWidget {
  final String leaderImage;
  final String leaderPhone;
  const LeaderPhone({Key key, this.leaderImage, this.leaderPhone})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: InkWell(onTap: _launchURL, child: Image.network(leaderImage)));
  }

  void _launchURL() async {
    String url = 'tel:' + leaderPhone;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}

// 商品栏
class Recommend extends StatelessWidget {
  final List recommendList;
  const Recommend({Key key, this.recommendList}) : super(key: key);
  // 商品标题
  Widget _titleWidget() {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.fromLTRB(10.0, 2.0, 0, 5.0),
      child: Text('商品推荐', style: TextStyle(color: Colors.pink)),
      decoration: BoxDecoration(
          color: Colors.white,
          border:
              Border(bottom: BorderSide(width: 0.5, color: Colors.black12))),
    );
  }

  // 商品横向列表
  Widget _recommedList() {
    return Expanded(
      child: Container(
        height: ScreenUtil().setHeight(330),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: recommendList.length,
          itemBuilder: (context, index) {
            return _item(context, index);
          },
        ),
      ),
    );
  }

  // 每一件商品

  Widget _item(context, index) {
    return InkWell(
      onTap: () {
        Application.router.navigateTo(
            context, "/detail?id=${recommendList[index]['goodsId']}");
      },
      child: Container(
          height: ScreenUtil().setHeight(330),
          width: ScreenUtil().setWidth(250),
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
              color: Colors.white,
              border:
                  Border(left: BorderSide(width: 0.5, color: Colors.black12))),
          child: Column(
            children: <Widget>[
              Image.network(recommendList[index]['image'], fit: BoxFit.fill),
              Text('￥${recommendList[index]['mallPrice']}'),
              Text(
                '￥${recommendList[index]['price']}',
                style: TextStyle(
                    decoration: TextDecoration.lineThrough, color: Colors.grey),
              )
            ],
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(380),
      margin: EdgeInsets.only(top: 10.0),
      child: Column(
        children: <Widget>[_titleWidget(), _recommedList()],
      ),
    );
  }
}

// 楼层标题

class FloorTitle extends StatelessWidget {
  final String picture_address;
  const FloorTitle({Key key, this.picture_address}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      child: Image.network(picture_address),
    );
  }
}
//楼层商品

class FloorContent extends StatelessWidget {
  // 数据列表
  final List floorGoodsList;

  const FloorContent({Key key, this.floorGoodsList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[_firstRow(context), _otherGoods(context)],
      ),
    );
  }

  Widget _firstRow(context) {
    return Row(
      children: <Widget>[
        _goodIthem(context, floorGoodsList[0]),
        Column(
          children: <Widget>[
            _goodIthem(context, floorGoodsList[1]),
            _goodIthem(context, floorGoodsList[2])
          ],
        )
      ],
    );
  }

  Widget _otherGoods(context) {
    return Row(
      children: <Widget>[
        _goodIthem(context, floorGoodsList[3]),
        _goodIthem(context, floorGoodsList[4])
      ],
    );
  }

  Widget _goodIthem(context, Map goods) {
    return Container(
      width: ScreenUtil().setWidth(375),
      child: InkWell(
        onTap: () {
          Application.router
              .navigateTo(context, "/detail?id=${goods['goodsId']}");
        },
        child: Image.network(goods['image']),
      ),
    );
  }
}
