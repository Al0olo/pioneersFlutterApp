import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
	return Scaffold(
	  appBar: AppBar(
		title: Text('Home Page'),
	  ),
	  body: Center(
		child: Column(
		  mainAxisAlignment: MainAxisAlignment.center,
		  children: <Widget>[
			Text('Welcome to the Home Page!'),
			ElevatedButton(
			  onPressed: () {
				Navigator.pushNamed(context, '/login');
			  },
			  child: Text('Go to About Page'),
			),
			ElevatedButton(
			  onPressed: () {
				Navigator.pushNamed(context, '/signup');
			  },
			  child: Text('Go to Contact Page'),
			),
		  ],
		),
	  ),
	);
  }
}