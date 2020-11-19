import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final flutterWebViewPlugin = new FlutterWebviewPlugin();

  loadJS(String name) async {
    var js = await rootBundle.loadString('assets/scripts/$name.js');
    flutterWebViewPlugin.onStateChanged.listen((viewState) async {
      if (viewState.type == WebViewState.finishLoad) {
        flutterWebViewPlugin.evalJavascript(js);
      }
    });
  }

  @override
  void initState() {
    loadJS('test');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
      url: 'https://laravel.gekongfei.cn',
    );
  }
}
