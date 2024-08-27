import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import '../firebase_options.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class LoginPage extends StatelessWidget {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _handleGoogleSignIn() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        // The user canceled the sign-in
        return;
      }
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final UserCredential userCredential = await _auth.signInWithCredential(credential);
      final User? user = userCredential.user;

      if (user != null) {
        // Successfully signed in
        // Navigate to the home page or perform other actions
        print('Successfully signed in: ${user.displayName}');
      }
    } catch (error) {
      print('Error signing in with Google: $error');
      // Handle sign-in error here
    }
  }

  Future<void> _handleFacebookSignIn() async {
    try {
      final LoginResult result = await FacebookAuth.instance.login();
      if (result.status == LoginStatus.success) {
        // final AccessToken accessToken = result.accessToken!;
        // final AuthCredential credential = FacebookAuthProvider.credential(accessToken);
        // final UserCredential userCredential = await _auth.signInWithCredential(credential);
        // final User? user = userCredential.user;
        final user = null;

        if (user != null) {
          // Successfully signed in
          // Navigate to the home page or perform other actions
          print('Successfully signed in: ${user.displayName}');
        }
      } else {
        print('Error signing in with Facebook: ${result.message}');
        // Handle sign-in error here
      }
    } catch (error) {
      print('Error signing in with Facebook: $error');
      // Handle sign-in error here
    }
  }

  Future<void> _handleEmailSignIn() async {
    try {
      final UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      final User? user = userCredential.user;

      if (user != null) {
        // Successfully signed in
        // Navigate to the home page or perform other actions
        print('Successfully signed in: ${user.email}');
      }
    } catch (error) {
      print('Error signing in with email: $error');
      // Handle sign-in error here
    }
  }

@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width * 0.8,
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'Email',
                ),
              ),
            ),
            SizedBox(height: 10),
            Container(
              width: MediaQuery.of(context).size.width * 0.8,
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'Password',
                ),
                obscureText: true,
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: _handleEmailSignIn,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue[900], // Dark blue background
                foregroundColor: Colors.white, // White text
              ),
              child: Text('Login with Email'),
            ),
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  onPressed: _handleGoogleSignIn,
                  icon: FaIcon(FontAwesomeIcons.google, color: Colors.white),
                  label: Text('Google'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red, // Google button color
                    foregroundColor: Colors.white, // Google button color
                  ),
                ),
                SizedBox(width: 10),
                ElevatedButton.icon(
                  onPressed: _handleFacebookSignIn,
                  icon: FaIcon(FontAwesomeIcons.facebook, color: Colors.white),
                  label: Text('Facebook'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue, // Facebook button color
                    foregroundColor: Colors.white, // Facebook button color
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}