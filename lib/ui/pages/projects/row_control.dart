import 'package:flutter/cupertino.dart';
import 'package:fluttereval/domain/project.dart';
import 'package:fluttereval/util/util_size.dart';
import 'package:provider/provider.dart';
import 'controller_project.dart';

class ControlRow extends StatelessWidget {
  final Control control;

  ControlRow(this.control);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          left: inchToPixel(control.at), top: inchToPixel(control.at2)),
      child: Row(
        children: [
          if (control.labelWidth != null)
            SizedBox(
              width: inchToPixel(control.labelWidth),
              child: Text(
                control.label,
                style: TextStyle(fontSize: 18),
              ),
            ),
          if (control.textController != null)
            SizedBox(
              width: inchToPixel(control.width),
              height:
                  control.height != null ? inchToPixel(control.height) : null,
              child: CupertinoTextField(
                enabled: context.watch<ProjectController>().fieldEnabled
                    ? true
                    : false,
                controller: control.textController,
                decoration: BoxDecoration(
                  color: context.watch<ProjectController>().fieldEnabled
                      ? null
                      : CupertinoColors.inactiveGray,
                  border: Border.all(color: CupertinoColors.black),
                  borderRadius: BorderRadius.all(
                    Radius.circular(8),
                  ),
                ),
              ),
            )
        ],
      ),
    );
  }
}
