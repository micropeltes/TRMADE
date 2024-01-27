import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUpPage extends StatelessWidget {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.lightBlueAccent,
        iconTheme: IconThemeData(color: Colors.white),
        // Blue-themed AppBar
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
                border: OutlineInputBorder(), // Added border
                prefixIcon:
                    Icon(Icons.email, color: Colors.blueAccent), // Email icon
              ),
            ),
            SizedBox(height: 10), // Added space for better UI
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(), // Added border
                prefixIcon:
                    Icon(Icons.lock, color: Colors.blueAccent), // Lock icon
              ),
              obscureText: true,
            ),
            SizedBox(height: 20), // Added space for better UI
            ElevatedButton(
              onPressed: () async {
                await signUpWithEmailAndPassword(
                    _emailController.text, _passwordController.text);
                // Navigate back to the login page after signing up
                Navigator.of(context).pop();
              },
              child: Text('Sign Up'),
              style: ElevatedButton.styleFrom(
                primary: Colors.blueAccent, // Consistent blue-themed button
                onPrimary: Colors.white,
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.lightBlue[50],
    );
  }

  Future<void> signUpWithEmailAndPassword(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } catch (e) {
      print(e);
      // Consider showing a dialog or snackbar to inform the user
      // Handle sign-up errors or show an alert dialog
    }
  }
}
