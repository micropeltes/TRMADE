import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NoteEditPage extends StatefulWidget {
  final String noteId;
  final String initialTitle;
  final String initialContent;

  NoteEditPage({
    required this.noteId,
    required this.initialTitle,
    required this.initialContent,
  });

  @override
  _NoteEditPageState createState() => _NoteEditPageState();
}

class _NoteEditPageState extends State<NoteEditPage> {
  late TextEditingController _titleController;
  late TextEditingController _noteController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.initialTitle);
    _noteController = TextEditingController(text: widget.initialContent);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Note', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.lightBlueAccent,
        iconTheme: IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            icon: Icon(Icons.check),
            onPressed: () {
              // Save the edited note
              _saveEditedNote();
              Navigator.pop(context); // Close the edit page
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Edit Note Title:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            TextField(
              controller: _titleController,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16), // Add some spacing between title and content
            Text(
              'Edit Note Content:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            TextField(
              controller: _noteController,
              style: TextStyle(fontSize: 16),
              maxLines: null,
            ),
          ],
        ),
      ),
      backgroundColor: Colors.lightBlue[50],
    );
  }

  void _saveEditedNote() {
    // Implement the logic to save the edited note to your database
    FirebaseFirestore.instance.collection('notes').doc(widget.noteId).update({
      'title': _titleController.text,
      'content': _noteController.text,
    });
  }
}
