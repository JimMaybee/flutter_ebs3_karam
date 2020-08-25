import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:fluttereval/data/repositories/repository_projects.dart';
import 'package:fluttereval/domain/project.dart';

class ProjectController extends ChangeNotifier {
  final ProjectRepository projectRepository;

  List<Project> projects;
  Project selectedProject;
  List<Control> selectedProjectControls;

  StreamSubscription _projectsStreamSubscription;

  StreamSubscription<List<Control>> _controlsStreamSubscription;

  bool deleteMode = false;
  bool fieldEnabled = false;

  ProjectController(this.projectRepository) {
    _projectsStreamSubscription = projectRepository.getAll().listen((projects) {
      this.projects = projects;

      notifyListeners();
    });
  }

  @override
  void dispose() {
    _projectsStreamSubscription.cancel();
    _controlsStreamSubscription?.cancel();
    super.dispose();
  }

  void selectProject(Project project) {
    print("New project selected: $project");
    selectedProject = project;

    this.selectedProjectControls = null;
    _getProjectControls(project.id);

    notifyListeners();
  }

  void _getProjectControls(String projectId) {
    _controlsStreamSubscription?.cancel();
    _controlsStreamSubscription =
        projectRepository.getProjectControls(projectId).listen((controls) {
      this.selectedProjectControls = controls;
      notifyListeners();
    });
  }

  void showCurrentData() {
    selectedProjectControls.forEach((element) {
      if (element.name != null)
        print("${element.name}: ${element.textController.value.text}");
    });
  }

  void toggleDeleteMode() {
    deleteMode = !deleteMode;
    notifyListeners();
  }

  void deleteProjectElement(int index) {
    deleteDocuments('projects', projects[index].id);
    notifyListeners();
  }

  void setFieldsEditable() {
    fieldEnabled = !fieldEnabled;
    notifyListeners();
  }

  void onChangeParameters(
      String collectionId, String documentId, String params) {
    projectRepository.setValue(collectionId, documentId, params);
    notifyListeners();
  }

  void deleteDocuments(String collectionId, String documentId) {
    projectRepository.deleteDocument(collectionId, documentId);
  }

  void addDocuments(String collectionId, String documentId) {
    projectRepository.addDocument(collectionId, documentId);
    notifyListeners();
  }
}
