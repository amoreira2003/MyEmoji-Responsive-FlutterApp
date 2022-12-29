import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'design_choices.dart';

class Auth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore db = FirebaseFirestore.instance;

  User? get currentUser => _firebaseAuth.currentUser;

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
  }

  Future<void> createUserWithEmailAndPassword(
      {required String email, required String password}) async {
    _firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      setAccountEmoji(value.user!.email);
    });
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  bool validateEmail(String? input) {
    input = input ?? "";
    final regExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return regExp.hasMatch(input);
  }

  Future<String> getAccountEmoji(String? email) async {
    String emoji = "";
    await db
        .collection("emojis")
        .where('email', isEqualTo: email)
        .get()
        .then((value) => {
              emoji = value.docs.first
                  .data()
                  .values
                  .firstWhere((element) => !validateEmail(element))
            });

    return emoji;
  }

  Future<void> setAccountEmoji(String? email) async {
    final userData = <String, dynamic>{
      'email': email,
      'emoji': emoji[Random().nextInt(emoji.length + 1)]
    };
    try {
      await db.collection('emojis').add(userData);
    } catch (e) {}
  }
}
