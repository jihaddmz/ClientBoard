import 'package:clientboard/feature_global/helper/helper_constants.dart';
import 'package:clientboard/feature_global/helper/helper_sharedpref.dart';
import 'package:clientboard/feature_project/model/model_project.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ProviderNewProject extends ChangeNotifier {
  String? _selectedDateTime;

  String? get selectedDateTime => _selectedDateTime;

  set selectedDateTime(String? value) {
    _selectedDateTime = value;
    notifyListeners();
  }

  String? _selectedMobilePlatform;

  String? get selectedMobilePlatform => _selectedMobilePlatform;

  set selectedMobilePlatform(String? platform) {
    _selectedMobilePlatform = platform;
    notifyListeners();
  }

  List<String>? users;

  void fetchUsers() async {
    users ??= [];
    await FirebaseFirestore.instance
        .collection("users")
        .get()
        .then((querySnapshot) {
      for (DocumentSnapshot documentSnapshot in querySnapshot.docs) {
        if (HelperSharedPref.getUsername() != documentSnapshot.id &&
            documentSnapshot.id != HelperConstants.adminName) {
          // don't add the current user to the list nor the admin one
          users!.add(documentSnapshot.id);
        }
      }
    });
  }

  Future<void> addProject(ModelProject project) async {
    // if the current user isn't the admin name, then add him/she as a collaborator so the project is visible to them
    // when filtered by collaborators
    if (HelperConstants.adminName != HelperSharedPref.getUsername()) {
      project.collaborators.add(HelperSharedPref.getUsername() ?? "");
    }
    await FirebaseFirestore.instance
        .collection("projects")
        .doc(project.name)
        .set(project.toFirestoreObject());
  }
}
