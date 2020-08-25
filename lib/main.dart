import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttereval/ui/pages/page_home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      theme: CupertinoThemeData(
        scaffoldBackgroundColor: CupertinoColors.white,
      ),
      title: 'Flutter Demo',
      home: HomePage(),
    );
  }
}
