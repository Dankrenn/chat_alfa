import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FirebaseAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<bool> isNicknameTaken(String nickname) async {
    QuerySnapshot<Map<String, dynamic>> result = await _firestore
        .collection('users')
        .where('nickname', isEqualTo: nickname)
        .get();

    return result.docs.isNotEmpty;
  }

  // Регистрация пользователя с пользовательским никнеймом
  Future<UserCredential?> registerUserWithNickname(String email, String password, String nickname) async {
    try {
      // Регистрация пользователя
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Сохранение никнейма в базе данных
      await _firestore.collection('users').doc(userCredential.user?.uid).set({
        'nickname': nickname,
      });

      return userCredential;
    } catch (e) {
      SnackBar(
        content: Text(
          'Registration error',
          style: TextStyle(fontSize: 20, color: Colors.red),
        ),
        duration: Duration(seconds: 5),
      );
      return null;
    }
  }



  // Вход пользователя
  Future<UserCredential?> signInUser(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential;
    } catch (e) {
      print('Sign in failed: $e');
      return null;
    }
  }

  // Выход пользователя
  Future<void> signOutUser() async {
    try {
      await _auth.signOut();
    } catch (e) {
      print('Sign out failed: $e');
    }
  }

  // Получение текущего пользователя
  User? getCurrentUser() {
    return _auth.currentUser;
  }

  // Отправка ссылки на сброс пароля
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      print('Password reset email failed: $e');
    }
  }
}
