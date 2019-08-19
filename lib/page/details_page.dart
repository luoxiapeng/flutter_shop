import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import '../Provide/details_info.dart';

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
              child: Column(
                children: <Widget>[
                   Text('${goodsId}')
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