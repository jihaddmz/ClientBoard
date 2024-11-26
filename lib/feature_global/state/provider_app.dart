import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../helper/helper_sharedpref.dart';
import '../helper/helper_constants.dart';

class ProviderApp extends ChangeNotifier {
  bool _isTyping = false;

  bool get isTyping => _isTyping;

  set isTyping(bool isTyping) {
    _isTyping = isTyping;
  }

  bool? _isOnline;

  bool? get isOnline => _isOnline;

  set isOnline(bool? isOnline) {
    _isOnline = isOnline;
    notifyListeners();
  }

  void setOnlineStatus(bool value) {
    FirebaseFirestore.instance
        .collection("users")
        .doc(HelperSharedPref.getUsername())
        .set({"online": value}, SetOptions(merge: true));
  }

  void fetchOnlineStatus(String collaborator) {
    var name = HelperSharedPref.getUsername() == HelperConstants.adminName
        ? collaborator
        : HelperConstants.adminName;

    _isOnline ??= false;
    FirebaseFirestore.instance
        .collection("users")
        .doc(name)
        .snapshots()
        .listen((documentSnapshot) {
      _isOnline = documentSnapshot.get("online");
      notifyListeners();
    });
  }
}
