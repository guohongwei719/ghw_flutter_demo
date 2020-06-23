import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math';


//// 官方demo
//
class KeyDemo1Page extends StatefulWidget {
  @override
  _KeyDemo1PageState createState() => _KeyDemo1PageState();
}

class _KeyDemo1PageState extends State<KeyDemo1Page> {

  List<Widget> tiles = [
    StatelessColorfulTile(),
    StatelessColorfulTile(),

  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        centerTitle: true,
        title: Text("Key demo"),
      ),
// 为啥 Row 和 ListView 不一样，一个变一个不变
//      body: ListView(children:tiles,),
      body: Row(children: tiles,),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.delete),
        onPressed: (){
          setState(() {
            tiles.insert(1, tiles.removeAt(0));
          });
        },
      ),
    );
  }
}


class StatelessColorfulTile extends StatelessWidget {
  Color myColor = Color.fromARGB(255, Random().nextInt(256), Random().nextInt(256), Random().nextInt(256));

  @override
  Widget build(BuildContext context) {
    return Container(
        color: myColor,
        child: Padding(padding: EdgeInsets.all(70.0))
    );
  }
}











// 第二步 StatelessColorfulTile 改为 StatefulWidget 那么久切换不成功



//class KeyDemo1Page extends StatefulWidget {
//  @override
//  _KeyDemo1PageState createState() => _KeyDemo1PageState();
//}
//
//class _KeyDemo1PageState extends State<KeyDemo1Page> {
//  List<StatelessColorfulTile> tiles = [
//    StatelessColorfulTile(),
//    StatelessColorfulTile(),
//  ];
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      appBar: AppBar(
//        backgroundColor: Colors.blue,
//        centerTitle: true,
//        title: Text("Key demo"),
//      ),
////      body: ListView(
////        children:tiles,
////      ),
//      body: Row(children: tiles,),
//      floatingActionButton: FloatingActionButton(
//        child: Icon(Icons.delete),
//        onPressed: (){
//          setState(() {
//            tiles.insert(1, tiles.removeAt(0));
//          });
//        },
//      ),
//    );
//  }
//}
//
//
//
//class StatelessColorfulTile extends StatefulWidget {
//  @override
//  _StatelessColorfulTileState createState() => _StatelessColorfulTileState();
//}
//
//class _StatelessColorfulTileState extends State<StatelessColorfulTile> {
//  Color myColor = Color.fromARGB(255, Random().nextInt(256), Random().nextInt(256), Random().nextInt(256));
//
//  @override
//  Widget build(BuildContext context) {
//    return Container(
//        color: myColor,
//        child: Padding(padding: EdgeInsets.all(70.0))
//    );
//  }
//}






// 第三不 使用了 key 以后就又可以切换了

//class KeyDemo1Page extends StatefulWidget {
//  @override
//  _KeyDemo1PageState createState() => _KeyDemo1PageState();
//}
//
//class _KeyDemo1PageState extends State<KeyDemo1Page> {
//  List<StatelessColorfulTile> tiles = [
//    StatelessColorfulTile(key: UniqueKey(),),
//    StatelessColorfulTile(key: UniqueKey(),),
//  ];
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      appBar: AppBar(
//        backgroundColor: Colors.blue,
//        centerTitle: true,
//        title: Text("Key demo"),
//      ),
////      body: ListView(
////        children:tiles,
////      ),
//      body: Row(children: tiles,),
//      floatingActionButton: FloatingActionButton(
//        child: Icon(Icons.delete),
//        onPressed: (){
//          setState(() {
//            tiles.insert(1, tiles.removeAt(0));
//          });
//        },
//      ),
//    );
//  }
//}
//
//
//
//class StatelessColorfulTile extends StatefulWidget {
//
//  StatelessColorfulTile({Key key}): super(key: key);
//
//  @override
//  _StatelessColorfulTileState createState() => _StatelessColorfulTileState();
//}
//
//class _StatelessColorfulTileState extends State<StatelessColorfulTile> {
//  Color myColor = Color.fromARGB(255, Random().nextInt(256), Random().nextInt(256), Random().nextInt(256));
//
//  @override
//  Widget build(BuildContext context) {
//    return Container(
//        color: myColor,
//        child: Padding(padding: EdgeInsets.all(70.0))
//    );
//  }
//}







// 第四步 在StatelessColorfulTile 外面包一个 Padding，要注意 key要提出来，不然还是会重新创建

//class KeyDemo1Page extends StatefulWidget {
//  @override
//  _KeyDemo1PageState createState() => _KeyDemo1PageState();
//}
//
//class _KeyDemo1PageState extends State<KeyDemo1Page> {
//
//  // 下面这样，每次点击按钮都会切换，颜色都会变化
////  List<Widget> tiles = [
////    Padding(
////      padding: const EdgeInsets.all(8.0),
////      child: StatelessColorfulTile(key: UniqueKey(),),
////    ),
////    Padding(
////      padding: const EdgeInsets.all(8.0),
////      child: StatelessColorfulTile(key: UniqueKey(),),
////    ),
////  ];
//
//  // 下面这样，把key 拿出来就好了。
//  List<Widget> tiles = [
//    Padding(
//      key: UniqueKey(),
//      padding: const EdgeInsets.all(8.0),
//      child: StatelessColorfulTile(),
//    ),
//    Padding(
//      key: UniqueKey(),
//      padding: const EdgeInsets.all(8.0),
//      child: StatelessColorfulTile(),
//    ),
//  ];
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      appBar: AppBar(
//        backgroundColor: Colors.blue,
//        centerTitle: true,
//        title: Text("Key demo"),
//      ),
////      body: ListView(
////        children:tiles,
////      ),
//      body: Row(children: tiles,),
//      floatingActionButton: FloatingActionButton(
//        child: Icon(Icons.delete),
//        onPressed: (){
//          setState(() {
//            tiles.insert(1, tiles.removeAt(0));
//          });
//        },
//      ),
//    );
//  }
//}
//
//
//
//class StatelessColorfulTile extends StatefulWidget {
//
//  StatelessColorfulTile({Key key}): super(key: key);
//
//  @override
//  _StatelessColorfulTileState createState() => _StatelessColorfulTileState();
//}
//
//class _StatelessColorfulTileState extends State<StatelessColorfulTile> {
//  Color myColor = Color.fromARGB(255, Random().nextInt(256), Random().nextInt(256), Random().nextInt(256));
//
//  @override
//  Widget build(BuildContext context) {
//    return Container(
//        color: myColor,
//        child: Padding(padding: EdgeInsets.all(70.0))
//    );
//  }
//}