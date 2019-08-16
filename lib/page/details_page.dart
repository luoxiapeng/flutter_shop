import 'package:flutter/material.dart';
class DetailsPage extends StatelessWidget {
  // const DetailsPage({Key key}) : super(key: key);
  
  final String goodsId;
  DetailsPage(this.goodsId);
  
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('${goodsId}'),
    );
  }
}