import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

String? authToken;

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
    final String email = _emailController.text;
    final String password = _passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      // Show error message
      return;
    }

    final response = await http.post(
      Uri.parse('https://yourapi.com/signup'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      // If the server returns a 200 OK response, parse the JSON.
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      authToken = responseData['token'];

      // Store the token using shared_preferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('authToken', authToken!);

      // Handle successful signup (e.g., navigate to another page, show success message)
    } else {
      // If the server did not return a 200 OK response, throw an exception.
      // Handle error (e.g., show error message)
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Signup'),
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
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                ),
              ),
            ),
            SizedBox(height: 10),
            Container(
              width: MediaQuery.of(context).size.width * 0.8,
              child: TextField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                ),
                obscureText: true,
              ),
            ),
            SizedBox(height: 20), // Larger margin after the password field
            ElevatedButton(
              onPressed: _handleEmailSignUp,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue[900], // Dark blue background
                foregroundColor: Colors.white, // White text
              ),
              child: Text('Signup with Email'),
            ),
            SizedBox(height: 30), // Larger margin after the signup button
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