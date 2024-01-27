import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'home_page.dart';
import 'signup_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String _error = ''; // To store error messages

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login', style: TextStyle(color: Colors.white)),
        backgroundColor:
            Colors.lightBlueAccent, // Consistent blue-themed AppBar
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                labelStyle: TextStyle(color: Colors.blueAccent),
                border: OutlineInputBorder(), // Added border for consistency
                prefixIcon:
                    Icon(Icons.email, color: Colors.blueAccent), // Email icon
              ),
            ),
            SizedBox(height: 10), // Added for better spacing
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
                labelStyle: TextStyle(color: Colors.blueAccent),
                border: OutlineInputBorder(), // Added border for consistency
                prefixIcon:
                    Icon(Icons.lock, color: Colors.blueAccent), // Password icon
              ),
              obscureText: true,
            ),
            SizedBox(height: 20), // Added for better spacing
            ElevatedButton(
              onPressed: () async {
                User? user = await signInWithEmailAndPassword(
                    _emailController.text, _passwordController.text);
                if (user != null) {
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => HomePage()));
                } else {
                  setState(() {
                    _error = 'Login failed. Please check your credentials.';
                  });
                }
              },
              child: Text('Login'),
              style: ElevatedButton.styleFrom(
                primary: Colors.blueAccent, // Consistent blue-themed button
                onPrimary: Colors.white,
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => SignUpPage()),
                );
              },
              child: Text('Sign Up'),
              style: TextButton.styleFrom(
                primary: Colors.blueAccent, // Blue text color
              ),
            ),
            if (_error.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  _error,
                  style: TextStyle(
                      color: Colors.red, fontSize: 14), // Error message style
                ),
              ),
          ],
        ),
      ),
      backgroundColor:
          Colors.lightBlue[50], // Light blue background for a fresh look
    );
  }

  Future<User?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return result.user;
    } catch (e) {
      print(e);
      return null;
    }
  }
}
