import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttereval/ui/pages/projects/controller_project.dart';
import 'package:provider/provider.dart';

class ProjectListTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var projects = context.watch<ProjectController>().projects;
    var selectedProject = context.watch<ProjectController>().selectedProject;
    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.extraLightBackgroundGray,
      navigationBar: CupertinoNavigationBar(
        leading: Padding(
          padding: const EdgeInsets.symmetric(vertical: 13.0),
          child: GestureDetector(
            child: context.watch<ProjectController>().deleteMode
                ? Text('Done',
                    style: TextStyle(color: CupertinoColors.destructiveRed))
                : Text('Edit'),
            onTap: () {
              context.read<ProjectController>().toggleDeleteMode();
            },
          ),
        ),
        middle: Text('Projects'),
        trailing: GestureDetector(
          onTap: () {
            context
                .read<ProjectController>()
                .addDocuments('projects', 'P${projects.length + 1}');
          },
          child: Icon(
            CupertinoIcons.add,
            color: CupertinoColors.activeBlue,
          ),
        ),
      ),
      child: projects == null
          ? Container()
          : ListView.separated(
              itemCount: projects.length,
              itemBuilder: (context, index) {
                var project = projects[index];
                return Row(
                  children: [
                    if (context.watch<ProjectController>().deleteMode)
                      Material(
                        child: Container(
                          width: 50,
                          child: FlatButton(
                            color: CupertinoColors.destructiveRed,
                            child: Icon(CupertinoIcons.delete),
                            onPressed: () {
                              Provider.of<ProjectController>(context,
                                      listen: false)
                                  .deleteProjectElement(index);
                            },
                          ),
                        ),
                      ),
                    Material(
                      child: InkWell(
                        onTap: () {
                          context
                              .read<ProjectController>()
                              .selectProject(project);
                        },
                        child: Container(
                          color: selectedProject == project
                              ? CupertinoColors.quaternaryLabel
                              : null,
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(project.id,
                                  style: TextStyle(
                                    color: CupertinoColors.black,
                                    fontSize: 25,
                                  )),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
              separatorBuilder: (context, index) {
                return Container(
                  height: 1,
                  color: CupertinoColors.separator,
                );
              },
            ),
    );
  }
}
