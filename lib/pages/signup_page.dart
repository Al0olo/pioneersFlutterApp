import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
    );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SignupPage(),
    );
  }
}

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
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
        // continue;
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

  Future<void> _handleEmailSignUp() async {
    try {
      final UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      final User? user = userCredential.user;

      if (user != null) {
        // Successfully signed up
        // Navigate to the home page or perform other actions
        print('Successfully signed up: ${user.email}');
      }
    } catch (error) {
      print('Error signing up with email: $error');
      // Handle sign-up error here
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Signup Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Sign up with:',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _handleFacebookSignIn,
              child: Text('Sign up with Facebook'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: _handleGoogleSignIn,
              child: Text('Sign up with Google'),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: _handleEmailSignUp,
              child: Text('Sign up with Email'),
            ),
          ],
        ),
      ),
    );
  }
}