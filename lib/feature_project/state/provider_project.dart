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
            projects!.add(ModelProject(
              documentChange.doc.id,
              documentChange.doc.get("deadline"),
              documentChange.doc.get("description"),
              documentChange.doc.get("features"),
              documentChange.doc.get("platforms"),
              documentChange.doc.get("budget"),
              List<String>.from(documentChange.doc.get("collaborators")),
              deadlineEdited: documentChange.doc.get("deadline_edited"),
              descriptionEdited: documentChange.doc.get("description_edited"),
              featuresEdited: documentChange.doc.get("features_edited"),
              budgetEdited: documentChange.doc.get("budget_edited"),
            ));
            notifyListeners();
          }
        }
      }
    });
  }

  void refreshProject(ModelProject project) {
    _project = project;
    notifyListeners();
  }

  Future<void> editProject(ModelProject project) async {
    await FirebaseFirestore.instance
        .collection("projects")
        .doc(project.name)
        .set(project.toFirestoreObject(), SetOptions(merge: true));
  }
}
