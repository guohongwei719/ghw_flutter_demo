import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math';


//// 第一步 每次点击删除所有的颜色都会变化
//
//
//class KeyDemo2Page extends StatefulWidget {
//  @override
//  _KeyDemo2PageState createState() => _KeyDemo2PageState();
//}
//
//class _KeyDemo2PageState extends State<KeyDemo2Page> {
//  final List<String> _names = ["1", "2", "3", "4", "5", "6", "7"];
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      appBar: AppBar(
//        backgroundColor: Colors.blue,
//        centerTitle: true,
//        title: Text("Key demo"),
//      ),
//      body: ListView(
//        children: _names.map((item) {
//          return KeyItemLessWidget(item);
//        }).toList(),
//      ),
//      floatingActionButton: FloatingActionButton(
//        child: Icon(Icons.delete),
//        onPressed: (){
//          setState(() {
//            _names.removeAt(0);
//          });
//        },
//      ),
//    );
//  }
//}
//
//class KeyItemLessWidget extends StatelessWidget {
//  final String name;
//  final randColor = Color.fromARGB(255, Random().nextInt(256), Random().nextInt(256), Random().nextInt(256));
//  KeyItemLessWidget(this.name);
//
//  @override
//  Widget build(BuildContext context) {
//    return Container(
//      child: Text(name, style: TextStyle(color: Colors.white, fontSize: 50),),
//      height: 80,
//      color: randColor,
//    );
//  }
//}





//************************************************************************************************************


//// 解决上面每次删除颜色都会变化的问题：解决办法：将 KeyItemLessWidget 转为 StatefulWidget
//// 虽然每次删除的时候颜色确实保留下来了，但是明明删除的第一个，结果显示删除的最后一个，还是不符合期望
//
//
//class KeyDemo2Page extends StatefulWidget {
//  @override
//  _KeyDemo2PageState createState() => _KeyDemo2PageState();
//}
//
//class _KeyDemo2PageState extends State<KeyDemo2Page> {
//  final List<String> _names = ["1", "2", "3", "4", "5", "6", "7"];
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      appBar: AppBar(
//        backgroundColor: Colors.blue,
//        centerTitle: true,
//        title: Text("Key demo"),
//      ),
//      body: ListView(
//        children: _names.map((item) {
//          return KeyItemLessWidget(item);
//        }).toList(),
//      ),
//      floatingActionButton: FloatingActionButton(
//        child: Icon(Icons.delete),
//        onPressed: (){
//          setState(() {
//            _names.removeAt(0);
//          });
//        },
//      ),
//    );
//  }
//}
//
//
//class KeyItemLessWidget extends StatefulWidget {
//  final String name;
//
//  KeyItemLessWidget(this.name);
//
//  @override
//  _KeyItemLessWidgetState createState() => _KeyItemLessWidgetState();
//}
//
//class _KeyItemLessWidgetState extends State<KeyItemLessWidget> {
//  final randColor = Color.fromARGB(255, Random().nextInt(256), Random().nextInt(256), Random().nextInt(256));
//
//  @override
//  Widget build(BuildContext context) {
//    return Container(
//      child: Text(widget.name, style: TextStyle(color: Colors.white, fontSize: 50),),
//      height: 80,
//      color: randColor,
//    );
//  }
//}









//************************************************************************************************************


//// 明明删除的第一个，结果显示删除的最后一个。解决办法：使用 Key
//
//class KeyDemo2Page extends StatefulWidget {
//  @override
//  _KeyDemo2PageState createState() => _KeyDemo2PageState();
//}
//
//class _KeyDemo2PageState extends State<KeyDemo2Page> {
//  final List<String> _names = ["1", "2", "3", "4", "5", "6", "7"];
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      appBar: AppBar(
//        backgroundColor: Colors.blue,
//        centerTitle: true,
//        title: Text("Key demo"),
//      ),
//      body: ListView(
//        children: _names.map((item) {
//          return KeyItemLessWidget(item, key: Key(item),);
//        }).toList(),
//      ),
//      floatingActionButton: FloatingActionButton(
//        child: Icon(Icons.delete),
//        onPressed: (){
//          setState(() {
//            _names.removeAt(0);
//          });
//        },
//      ),
//    );
//  }
//}
//
//
//class KeyItemLessWidget extends StatefulWidget {
//  final String name;
//
//  KeyItemLessWidget(this.name, {Key key}): super(key: key);
//
//  @override
//  _KeyItemLessWidgetState createState() => _KeyItemLessWidgetState();
//}
//
//class _KeyItemLessWidgetState extends State<KeyItemLessWidget> {
//  final randColor = Color.fromARGB(255, Random().nextInt(256), Random().nextInt(256), Random().nextInt(256));
//
//  @override
//  Widget build(BuildContext context) {
//    return Container(
//      child: Text(widget.name, style: TextStyle(color: Colors.white, fontSize: 50),),
//      height: 80,
//      color: randColor,
//    );
//  }
//}








//************************************************************************************************************


//// 使用 GlobalKey 可以获取到子 widget 里面的属性
//
class KeyDemo2Page extends StatefulWidget {
  @override
  _KeyDemo2PageState createState() => _KeyDemo2PageState();
}

class _KeyDemo2PageState extends State<KeyDemo2Page> {
  final List<String> _names = ["1", "2", "3", "4", "5", "6", "7"];
  final GlobalKey<_KeyItemLessWidgetState> globalKeyTest = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        centerTitle: true,
        title: Text("Key demo"),
      ),
//      body: ListView(
//        children: _names.map((item) {
//          return KeyItemLessWidget(item, key: Key(item),);
//        }).toList(),
//      ),
      body: KeyItemLessWidget("哈啰出行", key: globalKeyTest,),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.delete),
        onPressed: (){
//          setState(() {
//            _names.removeAt(0);
//          });
          print(globalKeyTest.currentState.widget.name);
        },
      ),
    );
  }
}


class KeyItemLessWidget extends StatefulWidget {
  final String name;

  KeyItemLessWidget(this.name, {Key key}): super(key: key);

  @override
  _KeyItemLessWidgetState createState() => _KeyItemLessWidgetState();
}

class _KeyItemLessWidgetState extends State<KeyItemLessWidget> {
  final randColor = Color.fromARGB(255, Random().nextInt(256), Random().nextInt(256), Random().nextInt(256));

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(widget.name, style: TextStyle(color: Colors.white, fontSize: 50),),
      height: 80,
      color: randColor,
    );
  }
}