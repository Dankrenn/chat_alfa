import 'package:chat_alfa/UI/RecoverPasswordScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'UI/AuthorizationScreen.dart';
import 'UI/HubScreen.dart';
import 'UI/RegistrationScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: 'AIzaSyDd6eU8JR_9WrxW6RJn7ltdidyoDelDCSc',
      appId: '1:117162863758:android:742449d1d0bd47bea86ddf',
      messagingSenderId: '117162863758',
      projectId: 'chatusertest-70794',
      storageBucket: 'chatusertest-70794.appspot.com',
    ),
  );

  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp ({super.key});

@override
Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ваше приложение',
      theme: ThemeData(
      ),
      home: RegistretionScreen(),
      routes: {
        '/Authoriz': (context) => AuthorizationScreen(),
        '/Registr': (context) => RegistretionScreen(),
        '/Hub': (context) => HubScreen(),
        '/RecoverPassword': (context) => RecoverPasswordScreen(),
      },
    );
  }
}
