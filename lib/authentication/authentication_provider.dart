import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthenticationProvider {
  final FirebaseAuth firebaseAuth;

  AuthenticationProvider(this.firebaseAuth);

  Stream<User> get authState => firebaseAuth.idTokenChanges();

  Future<void> signOut() async {
    await firebaseAuth.signOut();
  }

  // ignore: missing_return
  Future<String> signIn(
      {String email, String password, BuildContext context}) async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return "Signed in";
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.message.toString()),
        backgroundColor: Colors.red,
      ));
    }
  }

  // ignore: missing_return
  Future<String> signUp(
      {String email,
      String password,
      String name,
      BuildContext context}) async {
    try {
      await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) {
        FirebaseFirestore.instance
            .collection("userData")
            .doc(value.user.uid)
            .set({
          "name": name,
          "email": email,
          "imageUrl":
              'https://drive.google.com/uc?id=1TxVK9rL48OIERwL_7iWkZdKY1HM8-OvZ',
        });
      });
      return "Signed up";
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.message.toString()),
        backgroundColor: Colors.red,
      ));
    }
  }

  Future<String> uid() async {
    return firebaseAuth.currentUser.uid;
  }

  Future<void> resetPassword(String email) async {
    await firebaseAuth.sendPasswordResetEmail(email: email);
  }

  //Google

}
