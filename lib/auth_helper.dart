import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'login_user_model.dart';

class AuthHelper {
  AuthHelper._();
  static AuthHelper authHelper = AuthHelper._();
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final String usersCollectionName = 'Users';

  register(LoginUser loginUser) async {
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: loginUser.email, password: loginUser.password);
      String id = userCredential.user.uid;
      loginUser.id = id;
      saveUserInFirestore(loginUser);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  login(String email, String password) async {
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  logout() async {
    auth.signOut();
  }

  sendVerificationEmail() async {
    await auth.currentUser.sendEmailVerification();
  }

  resetPassword(String email) async {
    await auth.sendPasswordResetEmail(email: email);
  }

  saveUserInFirestore(LoginUser loginUser) async {
    try {
      firestore
          .collection(usersCollectionName)
          .doc(auth.currentUser.uid)
          .update({'age': 9});
    } on Exception catch (e) {
      print('error is $e');
    }
  }
}
