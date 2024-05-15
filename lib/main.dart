import 'package:chat/pages/Home_page.dart';
import 'package:chat/pages/Register_Page.dart';
import 'package:chat/pages/chatPage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        'LoginPage':(context)=>LoginPage(),
        'RegisterPage':(context)=>RegisterPage(),
        'ChatPage':(context)=>ChatPage(),
      },
     initialRoute: 'LoginPage',
    );
  }
}