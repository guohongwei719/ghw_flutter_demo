import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math';



//************************************************************************************************************

/*


 */




class StateDemoPage extends StatefulWidget {
  @override
  _StateDemoPageState createState() => _StateDemoPageState();
}

class _StateDemoPageState extends State<StateDemoPage> {
  int data = 100;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("InheritedWidget"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            GHWShowData01(),
            GHWShowData02()
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (){
          setState(() {
            data++;
          });
        },
      ),
    );
  }
}


class GHWShowData01 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      child: Text("当前计数：100", style: TextStyle(fontSize: 30),),
    );
  }
}

class GHWShowData02 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      child: Text("当前计数：100", style: TextStyle(fontSize: 30),),
    );
  }
}









////************************************************************************************************************
//
///*
//1. 点击按钮改变数据，需要增加构造方法；
//2. updateShouldNotify 方法返回true，会执行以来当前的 InheritedWidget 的 state 中的 didChangeDependencies 方法。
//InheritedWidget 有四点:
//1. 共享数据；
//2. 定义构造方法；
//3. 获取组件最近的当前 InheritedWidget
//4. 决定要不要回调 State 中的 didChangeDependencies
//5. 这个一般只用来共享数据，如果要修改可以用 Provider
// */
//
//
//class GHWDataWidget extends InheritedWidget {
//  // 有了构造函数 这里不需要赋值了
//  final int counter;
//
//  GHWDataWidget({this.counter, Widget child}): super(child: child);
//
//  static GHWDataWidget of(BuildContext context) {
//    // 沿着 Element 树找到最近的 GHWDataElement 对象，可以拿到对应的 GHWDataWidget, 点进源码看，抽象方法，子类有实现，快捷键 option+command+b 可以看子类实现，
//    //
//    return context.dependOnInheritedWidgetOfExactType();
//  }
//
//  @override
//  bool updateShouldNotify(GHWDataWidget oldWidget) {
//    // return false true 数据都会改, 但是不会执行 _GHWShowData01State 中的 didChangeDependencies
//    return this.counter != oldWidget.counter;
//  }
//}
//
//
//class StateDemoPage extends StatefulWidget {
//  @override
//  _StateDemoPageState createState() => _StateDemoPageState();
//}
//
//class _StateDemoPageState extends State<StateDemoPage> {
//  int data = 100;
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      appBar: AppBar(
//        title: Text("InheritedWidget"),
//      ),
//      body: GHWDataWidget(
//        counter: data,
//        child: Center(
//          child: Column(
//            mainAxisAlignment: MainAxisAlignment.center,
//            children: <Widget>[
//              GHWShowData01(),
//              GHWShowData02()
//            ],
//          ),
//        ),
//      ),
//
//      floatingActionButton: FloatingActionButton(
//        child: Icon(Icons.add),
//        onPressed: (){
//          setState(() {
//            data++;
//          });
//        },
//      ),
//    );
//  }
//}
//
//class GHWShowData01 extends StatefulWidget {
//  @override
//  _GHWShowData01State createState() => _GHWShowData01State();
//}
//
//class _GHWShowData01State extends State<GHWShowData01> {
//
//  @override
//  void didChangeDependencies() {
//    // TODO: implement didChangeDependencies
//    super.didChangeDependencies();
//    print("执行了_GHWShowData01State 中的 didChangeDependencies");
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    int counter = GHWDataWidget.of(context).counter;
//    return Container(
//      color: Colors.red,
//      child: Text("当前计数：$counter", style: TextStyle(fontSize: 30)),
//    );
//  }
//}
//
//class GHWShowData02 extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    int counter = GHWDataWidget.of(context).counter;
//    return Container(
//      color: Colors.blue,
//      child: Text("当前计数：$counter", style: TextStyle(fontSize: 30),),
//    );
//  }
//}









//************************************************************************************************************



// 这里可以共享 GHWDataWidget 里面的数据 但是还不能修改，需要修改的话要添加一个构造函数

//class GHWDataWidget extends InheritedWidget {
//  final int counter = 100;
//
//  GHWDataWidget({Widget child}): super(child: child);
//
//  static GHWDataWidget of(BuildContext context) {
//    // 沿着 Element 树找到最近的 GHWDataElement 对象，可以拿到对应的 GHWDataWidget
//    return context.dependOnInheritedWidgetOfExactType();
//  }
//
//  @override
//  bool updateShouldNotify(GHWDataWidget oldWidget) {
//    return this.counter != oldWidget.counter;
//  }
//}
//
//
//class StateDemoPage extends StatefulWidget {
//  @override
//  _StateDemoPageState createState() => _StateDemoPageState();
//}
//
//class _StateDemoPageState extends State<StateDemoPage> {
//  int data = 100;
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      appBar: AppBar(
//        title: Text("InheritedWidget"),
//      ),
//      body: GHWDataWidget(
//        child: Center(
//          child: Column(
//            mainAxisAlignment: MainAxisAlignment.center,
//            children: <Widget>[
//              HYShowData01(),
//              HYShowData02()
//            ],
//          ),
//        ),
//      ),
//
////      floatingActionButton: FloatingActionButton(
////        child: Icon(Icons.add),
////        onPressed: (){
////          setState(() {
////            data++;
////          });
////        },
////      ),
//    );
//  }
//}
//
//class HYShowData01 extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    int counter = GHWDataWidget.of(context).counter;
//    return Container(
//      color: Colors.red,
//      child: Text("当前计数：$counter", style: TextStyle(fontSize: 30)),
//    );
//  }
//}
//
//class HYShowData02 extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    int counter = GHWDataWidget.of(context).counter;
//    return Container(
//      color: Colors.blue,
//      child: Text("当前计数：$counter", style: TextStyle(fontSize: 30),),
//    );
//  }
//}
