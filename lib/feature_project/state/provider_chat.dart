import 'package:clientboard/feature_global/helper/helper_sharedpref.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ProviderChat extends ChangeNotifier {
  Stream<QuerySnapshot<Map<String, dynamic>>>? snapshots;

  void fetchSnapshots(String project) {
    snapshots = FirebaseFirestore.instance
        .collection("chats")
        .doc(project)
        .collection("messages")
        .orderBy("timestamp", descending: false)
        .snapshots();
    notifyListeners();
  }

  void addChat(String project, String text) {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('MMM dd, yyyy HH:mm:ss').format(now);
    FirebaseFirestore.instance
        .collection("chats")
        .doc(project)
        .collection("messages")
        .doc()
        .set({
      "sender": HelperSharedPref.getUsername(),
      "text": text,
      "timestamp": formattedDate
    });
  }
}
