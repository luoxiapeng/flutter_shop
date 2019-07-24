import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController typeController = TextEditingController();
  String showText = '欢迎你来到美好人间';
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text('动态渲染'),
        ),
        body: Container(
            child: Column(
          children: <Widget>[
            TextField(
              controller: typeController,
              decoration: InputDecoration(
                  labelText: '美好人间',
                  helperText: '请输入美女类型',
                  contentPadding: EdgeInsets.all(10.0)),
              autofocus: false,
            ),
            RaisedButton(
              child: Text('选择类型'),
              onPressed: () {
                _choseType();
              },
            ),
            Text(
              showText,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            )
          ],
        )),
      ),
    );
  }

  void _choseType() {
    print('请开始选择你的类型............');
    if (typeController.text.toString() == '') {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(title: Text('美女类型不能为空')));
    } else {
      GetHttp(typeController.text.toString()).then((val) {
        setState(() {
          showText = val['data']['name'];
        });
      });
    }
  }

  Future GetHttp(String TypeText) async {
    try {
      Response response;
      var data = {'name': TypeText};
      response = await Dio().get(
          'https://www.easy-mock.com/mock/5c60131a4bed3a6342711498/baixing/dabaojian',
          queryParameters: data);

      return response.data;
    } catch (e) {
      return print(e);
    }
  }
}
