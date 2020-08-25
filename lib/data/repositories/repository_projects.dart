import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttereval/domain/project.dart';
import 'package:rxdart/rxdart.dart';

class ProjectRepository {
  final Firestore _cloudStore = Firestore.instance;

  // ignore: close_sinks
  final _dataObservable = BehaviorSubject<List<Project>>();

  ProjectRepository() {
    _cloudStore.collection("projects").snapshots().listen((event) {
      _dataObservable.sink.add(event.documents
          .map((e) => Project(
              e.documentID,
              e.data["ClientName"].toString(),
              e.data["Daily"],
              e.data["Notes"].toString(),
              e.data["NumberOfInspections"],
              e.data["ProjectName"].toString(),
              e.data["Status"].toString()))
          .toList());
    });
  }

  Stream<List<Project>> getAll() {
    return _dataObservable;
  }

  Stream<List<Control>> getProjectControls(String projectId) {
    return _cloudStore
        .collection("forms")
        .document(projectId)
        .collection("controls")
        .snapshots()
        .map((event) {
      return event.documents
          .map((e) => Control(
                e.data["name"],
                e.data["label"],
                double.tryParse(e.data["at"].toString()),
                double.tryParse(e.data["at2"].toString()),
                double.tryParse(e.data["width"].toString()),
                double.tryParse(e.data["height"].toString()),
                double.tryParse(e.data["labelWidth"].toString()),
              ))
          .toList();
    });
  }

  void setValue(String collectionId, String documentId, String params) {
    var save = _cloudStore.collection(collectionId).document(documentId);
    save.setData({'ProjectName': params});
  }

  void deleteDocument(String collectionId, String documentId) {
    var save = _cloudStore.collection(collectionId).document(documentId);
    save.delete();
  }

  void addDocument(String collectionId, String documentId) {
    var save = _cloudStore.collection(collectionId);
    save.document('$documentId').setData({'ProjectName': ''});
  }
}
