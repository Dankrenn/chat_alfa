import 'package:chat_alfa/LogicUserRegistAndAutoriz/InputValidation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../UiMyClasses/MyClipper.dart';
import '../Firebase/FirebaseAuthService.dart';

class RegistretionScreen extends StatefulWidget {
  const RegistretionScreen({Key? key}) : super(key: key);

  @override
  State<RegistretionScreen> createState() => _RegistretionScreenState();
}

class _RegistretionScreenState extends State<RegistretionScreen> {
  bool showPassword = false;
  late String _emailUser = '';
  late String _nameUser = '';
  late String _passwordUser = '';
  late String _configPassword = '';
  String? nameError;
  String? emailError;
  String? passwordError;
  String? confirmPasswordError;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void _registerUser(BuildContext context) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: _emailUser,
        password: _passwordUser,
      );

      User? firebaseUser = userCredential.user;
      if (firebaseUser != null) {
        await firebaseUser.updateProfile(displayName: _nameUser);
        Navigator.pushNamedAndRemoveUntil(context, '/Quest', (route) => false);
      }
    } on FirebaseAuthException catch (e) {
      _showSnackBar(context, 'Error: ${e.message}');
    } catch (e) {
      _showSnackBar(context, 'User registration error: $e');
    }
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyle(fontSize: 20, color: Colors.red),
        ),
        duration: Duration(seconds: 5),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromRGBO(24, 26, 31, 1),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [


              Text(
                'Register In From',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Time New Roman',
                  color: Colors.white60,
                ),
              ),
              SizedBox(height: 7),
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
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          children: [
                            TextFormField(
                              onChanged: (value) async {
                                setState(() {
                                  nameError = InputValidator.validateName(value);
                                  if (nameError == null) {
                                    _nameUser = value;
                                  }
                                });
                              },
                              decoration: InputDecoration(
                                labelText: 'Name',
                                errorText: nameError,
                              ),
                            ),
                            SizedBox(height: 16.0),
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
                                errorText: emailError,
                              ),
                            ),
                            SizedBox(height: 16.0),
                            TextFormField(
                              obscureText: !showPassword,
                              onChanged: (value) {
                                setState(() {
                                  passwordError = InputValidator.validatePassword(value);
                                  if (passwordError == null) {
                                    _passwordUser = value;
                                  }
                                });
                              },
                              decoration: InputDecoration(
                                labelText: 'Password',
                                errorText: passwordError,
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    showPassword ? Icons.visibility : Icons.visibility_off,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      showPassword = !showPassword;
                                    });
                                  },
                                ),
                              ),
                            ),
                            TextFormField(
                              obscureText: !showPassword,
                              onChanged: (value) {
                                setState(() {
                                  confirmPasswordError =
                                      InputValidator.validateConfirmPassword(_passwordUser, value);
                                  if (confirmPasswordError == null) {
                                    _configPassword = value;
                                  }
                                });
                              },
                              decoration: InputDecoration(
                                labelText: 'Repeat password',
                                errorText: confirmPasswordError,
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    showPassword ? Icons.visibility : Icons.visibility_off,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      showPassword = !showPassword;
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
                    bottom: 1,
                    child: GestureDetector(
                      onTap: () {
                        if (_nameUser.isNotEmpty &&
                            _emailUser.isNotEmpty &&
                            _passwordUser.isNotEmpty &&
                            _configPassword.isNotEmpty) {
                          _registerUser(context);
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white12,
                          shape: BoxShape.circle,
                        ),
                        padding: EdgeInsets.all(12.0),
                        child: Icon(
                          Icons.play_arrow,
                          color: Colors.white60,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(context, '/Authoriz', (route) => false);
                },
                child: Text(
                  'Sign In Form',
                  style: TextStyle(
                    color: Colors.blueGrey,
                    fontSize: 16.0,
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
