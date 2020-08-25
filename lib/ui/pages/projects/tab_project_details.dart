import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttereval/ui/pages/projects/controller_project.dart';
import 'package:fluttereval/ui/pages/projects/row_control.dart';
import 'package:fluttereval/util/util_size.dart';
import 'package:provider/provider.dart';

class ProjectDetailsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var project = context.watch<ProjectController>().selectedProject;

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        leading: GestureDetector(
          onTap: () {
            context.read<ProjectController>().showCurrentData();
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 13.0),
            child: Text(
              "Cancel",
              style: TextStyle(color: CupertinoColors.activeBlue),
            ),
          ),
        ),
        middle: Text('Project Details'),
        trailing: GestureDetector(
          onTap: () {
            context.read<ProjectController>().setFieldsEditable();
          },
          child: context.watch<ProjectController>().fieldEnabled
              ? Text(
                  "Save",
                  style: TextStyle(color: CupertinoColors.activeBlue),
                )
              : Text(
                  "Edit",
                  style: TextStyle(color: CupertinoColors.activeBlue),
                ),
        ),
      ),
      child: project == null
          ? Center(
              child: Text(
                "Please select a project on the left first.",
                style: TextStyle(
                  color: CupertinoColors.black,
                  fontSize: 14,
                ),
              ),
            )
          : _ProjectDetails(context.watch<ProjectController>()),
    );
  }
}

class _ProjectDetails extends StatefulWidget {
  final ProjectController _projectController;

  _ProjectDetails(this._projectController)
      : super(key: ValueKey(_projectController.selectedProject.id));

  @override
  __ProjectDetailsState createState() => __ProjectDetailsState();
}

class __ProjectDetailsState extends State<_ProjectDetails> {
  double fadeInOpacity = 0;
  final projectController = TextEditingController();
  final secondController = TextEditingController();
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      setState(() {
        fadeInOpacity = 1;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var project = widget._projectController.selectedProject;
    var controls = widget._projectController.selectedProjectControls;
    projectController.text = project.projectName;
    secondController.text = project.clientName;
    return AnimatedOpacity(
      duration: Duration(milliseconds: 300),
      opacity: fadeInOpacity,
      child: Padding(
        padding: EdgeInsets.all(8.0),
        //left: inchToPixel(project.x), top: inchToPixel(project.y)),
        child: controls != null
            ? Stack(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        'Project Name',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: CupertinoColors.black, fontSize: 22),
                      ),
                      CupertinoTextField(
                        placeholder: 'Project Name',
                        controller: projectController,
                        onSubmitted: (projectName) {
                          context.read<ProjectController>().onChangeParameters(
                              'projects', project.id, projectName);
                        },
                      ),
                      //Checkbox(),
                    ],
                  ),
                ],
                //children: controls.map((e) => ControlRow(e)).toList(),
              )
            : Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
