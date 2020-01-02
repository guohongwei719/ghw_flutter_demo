import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:we_chat_demo/pages/root_page.dart';

//void main() => runApp(MyApp());

void main() {
  runApp(MyApp());
}

//
//
//class MyApp extends StatefulWidget {
//
//  final String pageIndex;
//
//  const MyApp({Key key, this.pageIndex}) : super(key: key);
//  @override
//  _MyAppState createState() => _MyAppState();
//}
//
//
//
//class _MyAppState extends State<MyApp> {
//
//  final MethodChannel _oneChannel = MethodChannel('one_page');
//  final MethodChannel _twoChannel = MethodChannel('two_page');
//
//  final BasicMessageChannel _messageChannel = BasicMessageChannel('messageChannel',StandardMessageCodec());
//
//  String _pageIndex = 'one';
//
//  @override
//  void initState() {
//
//    _messageChannel.setMessageHandler((message){
//      print('收到了来至iOS的:$message');
//    });
//
//    super.initState();
//    _oneChannel.setMethodCallHandler((MethodCall call){
//      _pageIndex = call.method;
//      setState(() {});
//    });
//    _twoChannel.setMethodCallHandler((MethodCall call){
//      _pageIndex = call.method;
//      setState(() {});
//    });
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return MaterialApp(
//      title: 'Flutter Demo',
//      theme: ThemeData(
//        primarySwatch: Colors.blue,
//      ),
//      home: rootPage(_pageIndex),
//    );
//  }
//
//
//
//  Widget rootPage(String index){
//    switch (index){
//      case 'one':
//        return Scaffold(
//          body: Column(
//            mainAxisAlignment: MainAxisAlignment.center,
//            children: <Widget>[
//              GestureDetector(
//                onTap: (){
//                  _oneChannel.invokeMethod('exit','arg');
//                },
//                child: Container(
//                  width: 100,height: 50,color: Colors.red,
//                  child: Text('one'),
//                ),
//              ),
//              TextField(
//                onChanged: (String str){
//                  _messageChannel.send(str);
//                },
//              )
//            ],
//          ),
//        );
//      case 'two':
//        return Center(
//          child: GestureDetector(
//            onTap: (){
//              _twoChannel.invokeMethod('exit','arg');
//            },
//            child: Container(
//              width: 100,height: 50,color: Colors.blue,
//              child: Text('two'),
//            ),
//          ),
//        );
//      default:
//        return Center(
//          child: GestureDetector(
//            child: Container(
//              width: 50,height: 50,color: Colors.red,
//              child: Text('default'),
//            ),
//          ),
//        );
//    }
//
//  }
//
//}





class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',//安卓里面
      theme: ThemeData(
        primarySwatch: Colors.yellow,
        highlightColor: Color.fromRGBO(1, 0, 0, 0.0),
        splashColor:  Color.fromRGBO(1, 0, 0, 0.0),
        cardColor: Color.fromRGBO(1, 1, 1, 0.65),
      ),
      home: RootPage(),
    );
  }
}






