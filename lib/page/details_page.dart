import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import '../Provide/details_info.dart';

// 页面拆分
import './details_page/details_top_area.dart';
import './details_page/details_explain.dart';
import './details_page/details_tabbar.dart';
import './details_page/detals_web.dart';

class DetailsPage extends StatelessWidget {
  // const DetailsPage({Key key}) : super(key: key);
  
  final String goodsId;
  DetailsPage(this.goodsId);
  
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: (){
            print('返回上一页');
            Navigator.pop(context);
          },
        ),
        title: Text('商品详情页'),
      ),
      body: FutureBuilder(
        future:  _getBackInfo(context),
        builder: (context,snapshot){
          if(snapshot.hasData){
            return Container(
              child: ListView(
                children: <Widget>[
                   DetailsTopArea(),
                   DetailsExplain(),
                   DetailsTabBar(),
                   DetailsWeb()
                ],
              ),
            );
          }else{
            return Text('加载中......');
          }
        },
      ),
    );
  }
  Future _getBackInfo(BuildContext context)  async{
    await Provide.value<DetailsInfoProvide>(context).getGoodsInfo(goodsId);
    print('加载完成............');
    return '加载完成';
  }
}