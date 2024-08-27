import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'pages/home_page.dart';
import 'pages/login_page.dart';
import 'pages/signup_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Firebase.initializeApp();
  Widget build(BuildContext context) {
	return MaterialApp(
	  title: 'Flutter Demo',
	  theme: ThemeData(
		primarySwatch: Colors.blue,
	  ),
	  initialRoute: '/',
	  routes: {
		'/': (context) => HomePage(),
		'/login': (context) => LoginPage(),
		'/signup': (context) => SignupPage(),
	  },
	);
  }
}