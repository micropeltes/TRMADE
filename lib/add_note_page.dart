import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AddNotePage extends StatelessWidget {
  final _titleController = TextEditingController();
  final _noteController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add Note',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.lightBlueAccent,
        iconTheme: IconThemeData(
            color: Colors.white), // Set back button color to white
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: 'Title',
                labelStyle: TextStyle(color: Colors.blue),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.lightBlue),
                ),
              ),
            ),
            TextField(
              controller: _noteController,
              decoration: InputDecoration(
                labelText: 'Note',
                labelStyle: TextStyle(color: Colors.blue),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                ),
              ),
              maxLines: null,
            ),
            Container(
              margin: EdgeInsets.only(top: 16),
              child: ElevatedButton(
                onPressed: () {
                  // Check if both title and note are not empty
                  if (_titleController.text.isNotEmpty &&
                      _noteController.text.isNotEmpty) {
                    // Add the note only if both title and note are not empty
                    addNote(
                      _titleController.text,
                      _noteController.text,
                    );
                    Navigator.of(context).pop(); // Go back after adding note
                  } else {
                    // Show a confirmation dialog if either title or note is empty
                    showConfirmationDialog(context);
                  }
                },
                child: Text('Add Note'),
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue,
                  onPrimary: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.lightBlue[50],
    );
  }

  void addNote(String noteTitle, String noteContent) async {
    try {
      // Get the current user from Firebase Auth
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        // Add the note with the user's ID
        await FirebaseFirestore.instance.collection('notes').add({
          'title': noteTitle,
          'content': noteContent,
          'userId': user.uid,
          'timestamp': FieldValue.serverTimestamp(),
        });
      }
    } catch (e) {
      print(e);
    }
  }

  void showConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirmation'),
          content: Text('Please enter both a title and a note.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
