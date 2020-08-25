import 'package:flutter/cupertino.dart';
import 'package:fluttereval/data/repositories/repository_projects.dart';
import 'package:fluttereval/ui/pages/projects/controller_project.dart';
import 'package:fluttereval/ui/pages/projects/tab_project_details.dart';
import 'package:fluttereval/ui/pages/projects/tab_project_list.dart';
import 'package:provider/provider.dart';

class ProjectsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;

    return ChangeNotifierProvider(
      create: (_) => ProjectController(ProjectRepository()),
      child: CupertinoTabView(
        builder: (BuildContext context) {
          return Row(
            children: [
              SizedBox(
                width: screenWidth * 0.2,
                child: ProjectListTab(),
              ),
              SizedBox(
                width: screenWidth * 0.8,
                height: double.infinity,
                child: ProjectDetailsTab(),
              )
            ],
          );
        },
      ),
    );
  }
}
