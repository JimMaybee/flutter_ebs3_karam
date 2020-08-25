import 'package:flutter/cupertino.dart';

class TemplatesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoTabView(
      builder: (BuildContext context) {
        return CupertinoPageScaffold(
          navigationBar: CupertinoNavigationBar(
            middle: Text('Templates'),
          ),
          child: Container(),
        );
      },
    );
  }
}
