import 'package:flutter/material.dart';

import '../const.dart';

class IndexBar extends StatefulWidget {
  final void Function(String str) indexBarCallBack;

  const IndexBar({Key key, this.indexBarCallBack}) : super(key: key);

  @override
  _IndexBarState createState() => _IndexBarState();
}

int getIndex(BuildContext context, Offset globalPosition) {
  RenderBox box = context.findRenderObject();
  //坐标转换，算出Y值！
  double y = box.globalToLocal(globalPosition).dy;
  //每一个Item的高度
  var itemHeight = ScreenHeight(context) / 2 / INDEX_WORDS.length;
  int index = (y ~/ itemHeight).clamp(0, INDEX_WORDS.length - 1);
  return index;
}

//带_的都是内部的。
class _IndexBarState extends State<IndexBar> {
  var _selectorIndex = -1;

  Color _bkColor = Color.fromRGBO(1, 1, 1, 0.0);
  Color _textColor = Colors.black;

  double _indicatorY = 0.0;
  String _indicatorText = 'A';
  bool _indicatorHidden = true;

  @override
  Widget build(BuildContext context) {
    List<Widget> words = [];
    for (int i = 0; i < INDEX_WORDS.length; i++) {
      words.add(Expanded(
          child: Text(
        INDEX_WORDS[i],
        style: TextStyle(fontSize: 10, color: _textColor),
      )));
    }

    return Positioned(
      right: 0.0,
      height: ScreenHeight(context) / 2,
      top: ScreenHeight(context) / 8,
      width: 120,
      child: Row(
        children: <Widget>[
          Container(
            alignment: Alignment(0, _indicatorY),
            width: 100,
            child: _indicatorHidden == true ? null : Stack(
              alignment: Alignment(-0.2, 0),
              children: <Widget>[
                Image(image: AssetImage('images/气泡.png'),width: 60,),
                Text(_indicatorText,style: TextStyle(
                  fontSize: 35,
                  color:Colors.white,
                ),)
              ],
            ),

          ),
          GestureDetector(
            child: Container(
              width: 20,
              color: _bkColor, //背景颜色
              child: Column(
                children: words,
              ), //悬浮检索控件
            ),
            onVerticalDragUpdate: (DragUpdateDetails details) {
              int index = getIndex(context, details.globalPosition);
              //计算外界回调
              if (index != _selectorIndex) {
                _selectorIndex = index;
                setState(() {});
                widget.indexBarCallBack(INDEX_WORDS[_selectorIndex]);
              }
              //内部气泡的显示！
              _indicatorText = INDEX_WORDS[index];
              _indicatorY = 2.2 / (INDEX_WORDS.length - 1) * index - 1.1;
              _indicatorHidden = false;
              setState(() {});

            },
            onVerticalDragDown: (DragDownDetails details) {
              int index = getIndex(context, details.globalPosition);
              //计算外界回调
              if (index != _selectorIndex) {
                _selectorIndex = index;
                setState(() {});
                widget.indexBarCallBack(INDEX_WORDS[_selectorIndex]);
              }
              //内部气泡的显示！
              _indicatorText = INDEX_WORDS[index];
              _indicatorY = 2.2 / (INDEX_WORDS.length - 1) * index - 1.1;
              _indicatorHidden = false;
              setState(() {
                _bkColor = Color.fromRGBO(1, 1, 1, 0.5);
                _textColor = Colors.white;
              });
            },
            onVerticalDragEnd: (DragEndDetails details) {
              _indicatorHidden = true;
              _bkColor = Color.fromRGBO(1, 1, 1, 0.0);
              _textColor = Colors.black;
              _selectorIndex = -1;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }
}

const INDEX_WORDS = [
  '🔍',
  '☆',
  'A',
  'B',
  'C',
  'D',
  'E',
  'F',
  'G',
  'H',
  'I',
  'J',
  'K',
  'L',
  'M',
  'N',
  'O',
  'P',
  'Q',
  'R',
  'S',
  'T',
  'U',
  'V',
  'W',
  'X',
  'Y',
  'Z'
];
