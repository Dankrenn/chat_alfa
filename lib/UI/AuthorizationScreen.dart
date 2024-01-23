import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../LogicUserRegistAndAutoriz/InputValidation.dart';
import '../UiMyClasses/MyClipper.dart';

class AuthorizationScreen extends StatefulWidget {
  const AuthorizationScreen({Key? key});

  @override
  State<AuthorizationScreen> createState() => _AuthorizationScreenState();
}

class _AuthorizationScreenState extends State<AuthorizationScreen> {
  bool showPassword1 = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late String _emailUser = '';
  late String _passwordUser = '';
  String? emailError;
  String? passwordError;
  void login(BuildContext context) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: _emailUser,
        password: _passwordUser,
      );
      // Если аутентификация прошла успешно, переходим на другой экран
      Navigator.pushNamedAndRemoveUntil(context, '/Hub', (route) => false);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found' || e.code == 'wrong-password') {
        SnackBar(
          content: Text(
            'Неправильный Email или пароль',
            style: TextStyle(fontSize: 20, color: Colors.red),
          ),
          duration: Duration(seconds: 5),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromRGBO(24, 26, 31, 1),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            children: [
              SizedBox(height: 120.0),
              Text(
                'Sign In From',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Time New Roman',
                  color: Colors.white60,
                ),
              ),
              SizedBox(height:7),
              Stack(
                children: [
                  ClipPath(
                    clipper: MyClipper(),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white12,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              onChanged: (value) {
                                setState(() {
                                  emailError = InputValidator.validateEmail(value);
                                  if (emailError == null) {
                                    _emailUser = value;
                                  }
                                });
                              },
                              decoration: InputDecoration(
                                labelText: 'Email',
                              ),
                            ),
                            SizedBox(height: 16.0),
                            TextFormField(
                              obscureText: !showPassword1,
                              onChanged: (value) {
                                setState(() {
                                  passwordError = InputValidator.validatePassword(value);
                                  if (passwordError == null) {
                                    _passwordUser = value;
                                  }
                                });
                              },
                              decoration: InputDecoration(
                                labelText: 'Пароль',
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    showPassword1
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      showPassword1 = !showPassword1;
                                    });
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    right: 0,
                    top: 0,
                    bottom: 16,
                    child: GestureDetector(
                      onTap: () {
                        login(context);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white12, // Цвет кнопки
                          shape: BoxShape.circle,
                        ),
                        padding: EdgeInsets.all(12.0),
                        child: Icon(
                          Icons.play_arrow,
                          color: Colors.white60, // Цвет стрелки
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              // Расстояние между кнопкой и текстом
              TextButton(
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(
                      context, '/Registr', (route) => false);
                },
                child: Text(
                  'Don\'t have an account? Sign Up',
                  style: TextStyle(
                    color: Colors.blueGrey,
                    fontSize: 16.0,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(
                      context, '/Registr', (route) => false);
                },
                child: Text(
                  'Forgot your password?',
                  style: TextStyle(
                    color: Colors.blueGrey,
                    fontSize: 14.0,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


