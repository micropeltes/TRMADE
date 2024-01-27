import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class NoteDetailPage extends StatelessWidget {
  final String noteTitle;
  final String noteContent;
  final Timestamp timestamp;

  NoteDetailPage({
    required this.noteTitle,
    required this.noteContent,
    required this.timestamp,
  });

  @override
  Widget build(BuildContext context) {
    // Format the timestamp using intl package (add it to your pubspec.yaml)
    // import 'package:intl/intl.dart';

    String formattedTimestamp =
        DateFormat('yyyy-MM-dd HH:mm:ss').format(timestamp.toDate());

    return Scaffold(
      appBar: AppBar(
        title: Text('Note Details', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.lightBlueAccent,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Note Title:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              noteTitle,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16), // Add some spacing between title and content
            Text(
              'Note Content:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              noteContent,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(
              'Time created:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              formattedTimestamp,
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.lightBlue[50],
    );
  }
}
