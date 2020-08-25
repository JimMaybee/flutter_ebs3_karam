import 'package:flutter/cupertino.dart';

class Project {
  final String id;
  final String clientName;
  final String projectName;
  final String notes;
  final String status;
  final bool daily;
  final int inspectionNumber;

  Project(this.id, this.clientName, this.daily, this.notes,
      this.inspectionNumber, this.projectName, this.status);

  @override
  String toString() {
    return 'Project{id: $id, clientName: $clientName, daily: $daily, notes: $notes, inspectionNumber: $inspectionNumber, projectName: $projectName, status: $status}';
  }
}

class Control {
  final String name;
  final String label;
  final double at;
  final double at2;
  final double width;
  final double height;
  final double labelWidth;

  TextEditingController textController;

  Control(this.name, this.label, this.at, this.at2, this.width, this.height,
      this.labelWidth) {
    if (name != null) {
      textController =
          TextEditingController.fromValue(TextEditingValue(text: ""));
    }
  }

  @override
  String toString() {
    return 'Control{name: $name, label: $label, at: $at, at2: $at2, width: $width, height: $height, labelWidth: $labelWidth, textController: $textController}';
  }
}
