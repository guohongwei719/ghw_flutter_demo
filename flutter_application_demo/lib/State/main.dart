import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutterapplicationdemo/State/ghw_counter_viewmodel.dart';
import 'package:flutterapplicationdemo/State/user_info_model.dart';
import 'package:flutterapplicationdemo/State/user_view_model.dart';
import 'package:provider/provider.dart';


/*
如果有多个要共享，怎么吧？
1. 嵌套，但是一般不这样
2. MultiProvider 数组拆到一个文件里面
3. Consumer2

Provider 使用非常重要，还是比较好用的，
 */

void main() {
  final userInfo = UserInfo("why", 29, "abc");
  runApp(
//      ChangeNotifierProvider(
//        create: (context) => GHWCounterViewModel(),
//        child: ChangeNotifierProvider(
//          create: (ctx) => GHWUserViewModel(userInfo),
//          child: MyApp(),
//        ),
//      )
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => GHWCounterViewModel(),),
        ChangeNotifierProvider(create: (ctx) => GHWUserViewModel(userInfo),)
      ],
      child: MyApp(),
    )
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Provider',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: StateDemoPage(),
    );
  }
}

class StateDemoPage extends StatefulWidget {
  @override
  _StateDemoPageState createState() => _StateDemoPageState();
}

class _StateDemoPageState extends State<StateDemoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Provider"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            GHWShowData01(),
            GHWShowData02(),
            GHWShowData03()
          ],
        ),
      ),

//      floatingActionButton: Consumer<GHWCounterViewModel>(
//        builder: (ctx, counterVM, child) {
//          print("floatingActionButton 中 的 Consumer 的 builder 方法");
//          return FloatingActionButton(
//            child: Icon(Icons.add),
//            onPressed: () {
//              counterVM.counter += 1;
//            },
//          );
//        },
//      ),


//      floatingActionButton: Consumer<GHWCounterViewModel>(
//        builder: (ctx, counterVM, child) {
//          print("floatingActionButton 中 的 Consumer 的 builder 方法");
//          return FloatingActionButton(
//            child: child,
//            onPressed: () {
//              counterVM.counter += 1;
//            },
//          );
//        },
//        child: Icon(Icons.add),
//      ),


      floatingActionButton: Selector<GHWCounterViewModel, GHWCounterViewModel>(
        selector: (ctx, counterVM) => counterVM,
        shouldRebuild: (pre, next) => false,  // 这个为 false 不执行 builder 方法，性能就比较高
        builder: (ctx, counterVM, child) {
          print("floatingActionButton 中 的 Consumer 的 builder 方法");
          return FloatingActionButton(
            child: child,
            onPressed: () {
              counterVM.counter += 1;
            },
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}


class GHWShowData01 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // 这种方式更简洁，但是使用更多的是 consumer
    int counter = Provider.of<GHWCounterViewModel>(context).counter;

    print("GHWShowData01 的build 方法");

    return Container(
      color: Colors.blue,
      child: Text("当前计数：$counter ", style: TextStyle(fontSize: 30),),
    );
  }
}

class GHWShowData02 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("02 的build 方法");

    return Container(
      color: Colors.red,
      child: Consumer<GHWCounterViewModel> (
        builder: (ctx, counterVM, child) {
          print("GHWShowData02 中 的 Consumer 的 builder 方法");
          return Text("当前计数：${counterVM.counter}", style: TextStyle(fontSize: 30));
        },
      ),
    );
  }
}


class GHWShowData03 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
//    return Consumer<GHWUserViewModel>(
//      builder: (ctx, userVM, child) {
//        return Text("nickname: ${userVM.user.nickname}");
//      },
//    );

    return Consumer2<GHWUserViewModel, GHWCounterViewModel>(
      builder: (ctx, userVM, counterVM, child) {
        return Text("nickname: ${userVM.user.nickname} counter: ${counterVM.counter}",
          style: TextStyle(fontSize: 30),

        );
      },
    );
  }
}














////************************************************************************************************************
//
///*
//使用 Provider 步骤
//1. 创建自己需要共享的数据
//2. 在应用程序的顶层 ChangeNotifierProvider
//3. 在其他位置使用共享的数据
//
//两种方式 Provider.of 和 Consumer，前者更简洁，后者使用更多, 使用前者当数据改变的时候 build 方法是要完整执行的
//Provider.of: 当 Provider中的数据发生改变时，整个build 方法重新调用
//Consumer 相对推荐：当 Provider 中的数据改变，不会执行 build 局部刷新 只会执行 Consumer 里面的build方法
//
//
//修改floatingActionButton 的 那个 Consumer, 对比不同点，后者性能更好
//每次都重新构建，浪费性能，所以用到了 builder 里面那个参数 child，这是第一步优化
//第二步优化 FloatingActionButton 都不需要构建
//
//
//selector: 1. selector 方法（作用，对原有数据进行转换）2 shouldRebuild(作用，要不要重新构建)
//
//一般comsumer 和 selector 搭配使用
// */
//
//void main() {
//  debugPaintSizeEnabled = false;
////  runApp(MyApp());
//  runApp(
//    ChangeNotifierProvider(
//      create: (context) => GHWCounterViewModel(),
//      child: MyApp(),
//    )
//  );
//}
//
//class MyApp extends StatelessWidget {
//  // This widget is the root of your application.
//  @override
//  Widget build(BuildContext context) {
//    return MaterialApp(
//      title: 'Provider',
//      theme: ThemeData(
//        primarySwatch: Colors.blue,
//      ),
//      home: StateDemoPage(),
//    );
//  }
//}
//
//class StateDemoPage extends StatefulWidget {
//  @override
//  _StateDemoPageState createState() => _StateDemoPageState();
//}
//
//class _StateDemoPageState extends State<StateDemoPage> {
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      appBar: AppBar(
//        title: Text("Provider"),
//      ),
//      body: Center(
//        child: Column(
//          mainAxisAlignment: MainAxisAlignment.center,
//          children: <Widget>[
//            GHWShowData01(),
//            GHWShowData02()
//          ],
//        ),
//      ),
//
////      floatingActionButton: Consumer<GHWCounterViewModel>(
////        builder: (ctx, counterVM, child) {
////          print("floatingActionButton 中 的 Consumer 的 builder 方法");
////          return FloatingActionButton(
////            child: Icon(Icons.add),
////            onPressed: () {
////              counterVM.counter += 1;
////            },
////          );
////        },
////      ),
//
//
////      floatingActionButton: Consumer<GHWCounterViewModel>(
////        builder: (ctx, counterVM, child) {
////          print("floatingActionButton 中 的 Consumer 的 builder 方法");
////          return FloatingActionButton(
////            child: child,
////            onPressed: () {
////              counterVM.counter += 1;
////            },
////          );
////        },
////        child: Icon(Icons.add),
////      ),
//
//
//      floatingActionButton: Selector<GHWCounterViewModel, GHWCounterViewModel>(
//        selector: (ctx, counterVM) => counterVM,
//        shouldRebuild: (pre, next) => false,  // 这个为 false 不执行 builder 方法，性能就比较高
//        builder: (ctx, counterVM, child) {
//          print("floatingActionButton 中 的 Consumer 的 builder 方法");
//          return FloatingActionButton(
//            child: child,
//            onPressed: () {
//              counterVM.counter += 1;
//            },
//          );
//        },
//        child: Icon(Icons.add),
//      ),
//    );
//  }
//}
//
//
//class GHWShowData01 extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    // 这种方式更简洁，但是使用更多的是 consumer
//    int counter = Provider.of<GHWCounterViewModel>(context).counter;
//
//    print("GHWShowData01 的build 方法");
//
//    return Container(
//      color: Colors.blue,
//      child: Text("当前计数：$counter ", style: TextStyle(fontSize: 30),),
//    );
//  }
//}
//
//class GHWShowData02 extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    print("02 的build 方法");
//
//    return Container(
//      color: Colors.red,
//      child: Consumer<GHWCounterViewModel> (
//        builder: (ctx, counterVM, child) {
//          print("GHWShowData02 中 的 Consumer 的 builder 方法");
//          return Text("当前计数：${counterVM.counter}", style: TextStyle(fontSize: 30));
//        },
//      ),
//    );
//  }
//}
