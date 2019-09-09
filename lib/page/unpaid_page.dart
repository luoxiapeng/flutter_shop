import 'package:flutter/material.dart';

class UnpaidPage extends StatefulWidget {
  UnpaidPage({Key key}) : super(key: key);

  _UnpaidPageState createState() => _UnpaidPageState();
}

class _UnpaidPageState extends State<UnpaidPage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  int _currentIndex = 0; //选中下标
  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(vsync: this, length: 5);
    _tabController.addListener(() => _onTabChanged());
    OnchangeTableIndex();
  }

  //默认进来这个页面的时候改变下标
  void OnchangeTableIndex() {
    setState(() {
      // 初始化下标
      _tabController.index = 1;
    });
  }

  ///
  /// tab改变监听
  ///
  _onTabChanged() {
    if (_tabController.index.toDouble() == _tabController.animation.value) {
      //赋值 并更新数据
      this.setState(() {
        // 点击的时候改变
        _currentIndex = _tabController.index;
        print(_currentIndex);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('待付款'),
          bottom: new TabBar(
              tabs: <Widget>[
                Tab(text: '全部'),
                Tab(text: '待付款'),
                Tab(text: '待发货'),
                Tab(text: '待收货'),
                Tab(text: '待评价')
              ],
              controller: _tabController,
              // isScrollable: true,
              indicatorColor: Colors.pinkAccent),
        ),
        body: new TabBarView(
          controller: _tabController,
          children: <Widget>[
            new Center(child: new Text('全部')),
            new Center(child: new Text('待付款')),
            new Center(child: new Text('待发货')),
            new Center(child: new Text('待收货')),
            new Center(child: new Text('待评价')),
          ],
        ));
  }
}
