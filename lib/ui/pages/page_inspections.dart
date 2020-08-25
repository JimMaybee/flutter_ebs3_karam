import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InspectionsPage extends StatefulWidget {
  @override
  _InspectionsPageState createState() => _InspectionsPageState();
}

class _InspectionsPageState extends State<InspectionsPage> {
  TapDownDetails details;

  @override
  Widget build(BuildContext context) {
    return  CupertinoTabView(
      builder: (BuildContext context) {
        return CupertinoPageScaffold(
          navigationBar: CupertinoNavigationBar(
            middle: Text('Inspections'),
          ),
          child: GestureDetector(
            onTapDown: (TapDownDetails details){
              setState(() {
                this.details = details;
              });
            },
            child: Container(
              color: Colors.red,
              width: double.infinity,
              height: double.infinity,
              child: Center(
                child: Text("TapDownDetails: ${details?.globalPosition}"),
              ),
            ),
          ),
        );
      },
    );
  }
}
