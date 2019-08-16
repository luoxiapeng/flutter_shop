import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import '../Provide/details_info.dart';

class DetailsPage extends StatelessWidget {
  // const DetailsPage({Key key}) : super(key: key);
  
  final String goodsId;
  DetailsPage(this.goodsId);
  
  @override
  Widget build(BuildContext context) {
    _getBackInfo(context);
    return Container(
      child: Text('${goodsId}'),
    );
  }
  void _getBackInfo(BuildContext context){
    Provide.value<DetailsInfoProvide>(context).getGoodsInfo(goodsId);
  }
}