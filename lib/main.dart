import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
        apiKey: "AIzaSyCNQ6CpfNxtVmqy7hSdla6F-KY5ZRFEZSY",
        authDomain: "notepad-80aef.firebaseapp.com",
        projectId: "notepad-80aef",
        storageBucket: "notepad-80aef.appspot.com",
        messagingSenderId: "879993122800",
        appId: "1:879993122800:web:772e3ac4cb668f7cb3b735"),
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Note App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(), // Start with the login page
    );
  }
}
