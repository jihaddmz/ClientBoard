import 'package:clientboard/feature_global/helper/helper_sharedpref.dart';
import 'package:clientboard/feature_global/helper/helper_constants.dart';
import 'package:clientboard/feature_project/model/model_chat.dart';
import 'package:clientboard/feature_project/model/model_project.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ProviderProject extends ChangeNotifier {
  ModelProject? _project;

  ModelProject? get project => _project;

  set project(ModelProject? project) {
    _project = project;
  }

  List<ModelChat>? _chats;

  List<ModelChat>? get chats => _chats;

  set addChat(ModelChat chat) {
    _chats ??= [];
    _chats!.add(chat);
    notifyListeners();
  }

  List<ModelProject>? projects;

  void fetchProjects() {
    FirebaseFirestore.instance
        .collection("projects")
        .snapshots()
        .listen((snapshot) {
      for (var documentChange in snapshot.docChanges) {
        if (documentChange.type == DocumentChangeType.added) {
          if (List<String>.from(documentChange.doc.get("collaborators"))
                  .contains(HelperSharedPref.getUsername()) ||
              HelperSharedPref.getUsername() == HelperConstants.adminName) {
            // if the current user is the admin developer one, or if he/she is one of the collaborators, add the project
            projects ??= [];
            projects!.add(ModelProject.fromFirestore(
                documentChange.doc.data()!, documentChange.doc.id));
            notifyListeners();
          }
        }
      }
    });
  }

  Future<void> approveProjectChanges(ModelProject project) async {
    Map<String, dynamic> map = {
      "budget": project.budgetEdited.isNotEmpty
          ? project.budgetEdited
          : project.budget,
      "budget_edited": "",
      "collaborators": project.collaborators,
      "deadline": project.deadlineEdited.isNotEmpty
          ? project.deadlineEdited
          : project.deadline,
      "deadline_edited": "",
      "description": project.descriptionEdited.isNotEmpty
          ? project.descriptionEdited
          : project.description,
      "description_edited": "",
      "features": project.featuresEdited.isNotEmpty
          ? project.featuresEdited
          : project.features,
      "features_edited": "",
      "platforms": project.platforms
    };

    await FirebaseFirestore.instance
        .collection("projects")
        .doc(project.name)
        .set(map);
  }

  void refreshProject(ModelProject project) {
    _project = project;
    notifyListeners();
  }

  Future<void> reFetchProject(String projectName) async {
    await FirebaseFirestore.instance
        .collection("projects")
        .doc(projectName)
        .get()
        .then((querySnapshot) {
      _project =
          ModelProject.fromFirestore(querySnapshot.data()!, querySnapshot.id);
      notifyListeners();
    });
  }

  Future<void> editProject(ModelProject project) async {
    await FirebaseFirestore.instance
        .collection("projects")
        .doc(project.name)
        .set(project.toFirestoreObject(), SetOptions(merge: true));
  }
}
