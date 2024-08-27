import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
	return Scaffold(
	  body: Center(
		child: Column(
		  mainAxisAlignment: MainAxisAlignment.center,
		  children: <Widget>[
			FlutterLogo(size: 48), // Flutter icon as a placeholder for the app icon
			SizedBox(height: 8), // Space between the icon and the title
			Text(
			  'Pioneers',
			  style: TextStyle(
				fontSize: 32,
				fontWeight: FontWeight.bold,
				color: Colors.black,
			  ),
			),
			SizedBox(height: 20), // Space between the title and the buttons
			ElevatedButton(
			  onPressed: () {
				Navigator.pushNamed(context, '/login');
			  },
			  style: ElevatedButton.styleFrom(
				backgroundColor: Colors.blue[900], // Dark blue background
				foregroundColor: Colors.white, // White text
				textStyle: TextStyle(
				  fontFamily: 'Sans-serif',
				  fontSize: 16,
				),
			  ),
			  child: Text('Go to Login Page'),
			),
			SizedBox(height: 10),
			ElevatedButton(
			  onPressed: () {
				Navigator.pushNamed(context, '/signup');
			  },
			  style: ElevatedButton.styleFrom(
				backgroundColor: Colors.blue[900], // Dark blue background
				foregroundColor: Colors.white, // White text
				textStyle: TextStyle(
				  fontFamily: 'Sans-serif',
				  fontSize: 16,
				),
			  ),
			  child: Text('Go to Signup Page'),
			),
		  ],
		),
	  ),
	);
  }
}