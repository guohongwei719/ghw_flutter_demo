import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'discover/discover_cell.dart';

class MinePage extends StatefulWidget {
  @override
  _MinePageState createState() => _MinePageState();
}

class _MinePageState extends State<MinePage> {

  MethodChannel _methodChannel  = MethodChannel('mine_page/method');

  Widget headerWidget() {
    return Container(
      height: 200,
      color: Colors.white,
      child: Container(
        margin: EdgeInsets.only(top: 100),
        padding: EdgeInsets.all(10),
        child: Container(
          margin: EdgeInsets.only(left: 20),
          child: Row(
            children: <Widget>[
              Container(
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  image: DecorationImage(image: AssetImage('images/Hank.png'),
                  ),
                ),
              ), //头像
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(left: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        alignment: Alignment.centerLeft,
                        height: 35,
                        child: Text('Hank',style: TextStyle(fontSize: 25),),
                      ), //微信昵称
                      Container(
                        height: 35,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text('微信号：123456', style: TextStyle(
                                fontSize: 17,
                                color: Colors.grey
                            ),), //微信号
                            Image(image: AssetImage('images/icon_right.png'),
                              width: 15,) //箭头
                          ],
                        ),
                      ), //账号
                    ],
                  ),
                ),
              ), //右边部分
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _methodChannel.setMethodCallHandler((MethodCall call){
      print(call.arguments);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(
          children: <Widget>[
            Container(
              color: Color.fromRGBO(220, 220, 220, 1),
              child: MediaQuery.removePadding(
                removeTop: true,
                context: context,
                child: ListView(
                  children: <Widget>[
                    headerWidget(), //头部
                    SizedBox(height: 10,),
                    DiscoverCell(imageName: 'images/微信支付1.png', title: '支付',),
                    SizedBox(
                      height: 10,
                    ),
                    DiscoverCell(
                      imageName: 'images/微信收藏.png',
                      title: '收藏',
                    ),
                    Row(
                      children: <Widget>[
                        Container(
                            width: 50, height: 0.5, color: Colors.white),
                        Container(height: 0.5, color: Colors.grey)
                      ],
                    ), //分割线
                    DiscoverCell(
                      imageName: 'images/微信相册.png',
                      title: '相册',
                    ),
                    Row(
                      children: <Widget>[
                        Container(
                            width: 50, height: 0.5, color: Colors.white),
                        Container(height: 0.5, color: Colors.grey)
                      ],
                    ), //分割线
                    DiscoverCell(
                      imageName: 'images/微信卡包.png',
                      title: '卡包',
                    ),
                    Row(
                      children: <Widget>[
                        Container(
                            width: 50, height: 0.5, color: Colors.white),
                        Container(height: 0.5, color: Colors.grey)
                      ],
                    ), //分割线
                    DiscoverCell(
                      imageName: 'images/微信表情.png',
                      title: '表情',
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    DiscoverCell(
                      imageName: 'images/微信设置.png',
                      title: '设置',
                    ),
                  ],
                ),
              ),
            ), //列表
            GestureDetector(
              onTap: (){
                _methodChannel.invokeMethod('picture');
              },
              child: Container(
                margin: EdgeInsets.only(top: 40, right: 10),
                height: 25,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Image(image: AssetImage('images/tabbar_chat_hl.png')),
                  ],
                ),
              ),
            ), //相机
          ],
        ),
      ),
    );
  }
}
