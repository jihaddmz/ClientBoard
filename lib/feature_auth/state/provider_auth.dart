import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../feature_global/helper/helper_sharedpref.dart';
import '../../feature_global/model/model_usecase_result.dart';

class ProviderAuth extends ChangeNotifier {
  Future<ModelUseCaseResult<AdditionalUserInfo>> registerWithEmail(
      String email, String password, String name) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      userCredential.user!.updateDisplayName(name);
      await HelperSharedPref.setIsSignedUp(true);
      await addUser(name, email);
      return ModelUseCaseResult(userCredential.additionalUserInfo, null);
    } on FirebaseAuthException catch (e) {
      return ModelUseCaseResult(null, e.message);
    }
  }

  Future<bool> resetPassword(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      return true;
    } on FirebaseAuthException catch (e) {
      return false;
    }
  }

  Future<void> addUser(String name, String email) async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(name)
        .set({"email": email, "online": false});
  }

  Future<ModelUseCaseResult<User>> signInWithEmail(
      String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      await HelperSharedPref.setUsername(
          userCredential.user!.displayName ?? "User");
      await HelperSharedPref.setEmail(userCredential.user!.email!);
      await HelperSharedPref.setPassword(password);
      return ModelUseCaseResult(userCredential.user, null);
    } on FirebaseAuthException catch (e) {
      return ModelUseCaseResult(null, e.message);
    }
  }
}
