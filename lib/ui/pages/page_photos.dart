import 'package:flutter/cupertino.dart';

class PhotosPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoTabView(
      builder: (BuildContext context) {
        return CupertinoPageScaffold(
          navigationBar: CupertinoNavigationBar(
            middle: Text('Photo'),
          ),
          child: Container(),
        );
      },
    );
  }
}
