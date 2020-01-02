import 'package:flutter/material.dart';
import 'package:we_chat_demo/pages/chat/search_bar.dart';

import '../const.dart';
import 'chat.dart';

class SearchPage extends StatefulWidget {
  final List<Chat> datas;

  const SearchPage({Key key, this.datas}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<Chat> _modals = []; //内容显示根据模型数组来！！
  String _searchStr = '';

  void _serachData(String text) {
    if (text.length == 0) {
      _modals = [];
    } else {
      _modals.clear();
      for (int i = 0; i < widget.datas.length; i++) {
        if (widget.datas[i].name.contains(text)) {
          _modals.add(widget.datas[i]);
        }
      }
    }
    _searchStr = text;
    setState(() {});
  }

  Widget _title(String name) {
    TextStyle normalStyle = TextStyle(fontSize: 16, color: Colors.black);
    TextStyle highlighStyle = TextStyle(fontSize: 16, color: Colors.green);

    List<TextSpan> spans = [];
    //找到哪些是高亮的哪些是黑色的。
    List<String> strs = name.split(_searchStr);
    for (int i = 0; i < strs.length; i++) {
      String str = strs[i];
      if (str == '' && i < strs.length - 1) {
        spans.add(TextSpan(text: _searchStr, style: highlighStyle));
      } else {
        spans.add(TextSpan(text: str, style: normalStyle));
        if (i < strs.length - 1) {
          //只要不是最后一个
          spans.add(TextSpan(text: _searchStr, style: highlighStyle));
        }
      }
    }

    return RichText(
      text: TextSpan(children: spans),
    );
  }

  Widget _itemForRow(BuildContext context, int index) {
    return ListTile(
      title: _title(_modals[index].name), //
      subtitle: Container(
        height: 20,
        width: 20,
        child: Text(
          _modals[index].message,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(_modals[index].imageUrl),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          SearchBar(
            onChanged: (String str) {
              _serachData(str);
            },
          ),
          Expanded(
            flex: 1,
            child: MediaQuery.removePadding(
                removeTop: true,
                context: context,
                child: NotificationListener(
                  onNotification: (ScrollNotification note){
                    FocusScope.of(context).requestFocus(FocusNode());
                  },
                    child: ListView.builder(
                  itemCount: _modals.length,
                  itemBuilder: _itemForRow,
                ))),
          )
        ],
      ),
    );
  }
}
