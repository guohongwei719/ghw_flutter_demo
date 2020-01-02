import 'package:flutter/material.dart';
import 'package:we_chat_demo/pages/chat/search_bar.dart';
import 'dart:convert';
import '../const.dart';
import 'package:http/http.dart' as http;

import 'chat.dart';

/** 混入（Mixins）
 *  用来给类增加功能。with 混入一个或多个mixin
 * */

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

//创建Item的方法！
PopupMenuItem<String> _buildItem(String imgAss, String title) {
  return PopupMenuItem(
    child: Row(
      children: <Widget>[
        Image(
          image: AssetImage(imgAss),
          width: 20,
        ),
        Container(
          width: 20,
        ),
        Text(
          title,
          style: TextStyle(color: Colors.white),
        ),
      ],
    ),
  );
}

//回调方法
List<PopupMenuItem<String>> _buildPopupMunuItem(BuildContext context) {
  return <PopupMenuItem<String>>[
    _buildItem('images/发起群聊.png', '发起群聊'),
    _buildItem('images/添加朋友.png', '添加朋友'),
    _buildItem('images/扫一扫1.png', '扫一扫'),
    _buildItem('images/收付款.png', '收付款'),
  ];
}

/**
 *  final chat = {
    //      'name' : '张三',
    //      'message' : '吃饭了吗？',
    //    };
    //    //Map 转 Json
    //    final chatJson = json.encode(chat);
    //    print(chatJson);
    //    //Json 转Map
    //    final newChat = json.decode(chatJson);
    //    final chatModle = Chat.formJson(newChat);
    //    print('name:${chatModle.name}  message:${chatModle.message}');

 *
 * */ //Json和模型之间的转换！

class _ChatPageState extends State<ChatPage>
with AutomaticKeepAliveClientMixin<ChatPage>{
  List<Chat> _datas = [];

  bool _cancelConnect = false;//多次请求！

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();

    getDatas().then((List<Chat> datas) {
      if(!_cancelConnect){
        setState(() {
          _datas = datas;
        });
      }
    }).catchError((e) {
      print(e);
    }).whenComplete((){
      print('完毕');
    }).timeout(Duration(seconds: 6)).catchError((timeout){
      _cancelConnect = true;
      print('超时:${timeout}');
    });
  }

  Future<List<Chat>> getDatas() async {
    _cancelConnect = false;
    final response = await http
        .get('http://rap2api.taobao.org/app/mock/224518/api/chat/list');

    if (response.statusCode == 200) {
      //获取响应数据，并且转换成Map类型
      final resonseBody = json.decode(response.body);

      //转换模型数组
      List<Chat> chatList = resonseBody['chat_list']
          .map<Chat>((item) => Chat.formJson(item))
          .toList();

      return chatList;
    } else {
      throw Exception('statusCode:${response.statusCode}');
    }
  }

  //返回Item
  Widget _buildItemForRow(BuildContext context, int index) {
    if(index == 0){
      return SearchCell(datas: _datas,);
    }//searchCell
    return ListTile(
      title: Text(_datas[index - 1].name),
      subtitle: Container(
        height: 20,
        width: 20,
        child: Text(
          _datas[index - 1].message,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(_datas[index - 1].imageUrl),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        elevation:0.0,
        backgroundColor: WeChatThemeColor,
        centerTitle: true,
        title: Text('微信'),
        actions: <Widget>[
          Container(
            margin: EdgeInsets.only(right: 10),
            child: PopupMenuButton(
              offset: Offset(0, 60.0),
              child: Image(
                image: AssetImage('images/圆加.png'),
                width: 25,
              ),
              itemBuilder: _buildPopupMunuItem,
            ),
          )
        ],
      ),
      body: Container(
          child: _datas.length == 0
              ? Center(
                  child: Text('Loading..'),
                )
              : ListView.builder(
                  itemCount: _datas.length + 1,
                  itemBuilder: _buildItemForRow,
                )),
    );
  }
}

/*
* FutureBuilder(
        future: getDatas(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Text('Loading...'),
            );
          } else {
            return ListView(
              children: snapshot.data.map<Widget>((item) {
                return ListTile(
                  title: Text(item.name),
                  subtitle: Container(height: 20,width: 20,child: Text(item.message,overflow: TextOverflow.ellipsis,),),
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(item.imageUrl),
                  ),
                );
              }).toList(),
            );
          }
        },
      )
* */ //FutureBuilder
