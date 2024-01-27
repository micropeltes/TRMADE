import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'add_note_page.dart';
import 'login_page.dart';
import 'note_detail_page.dart';
import 'note_edit_page.dart'; // Import the new page

final FirebaseAuth _auth = FirebaseAuth.instance;

User? getCurrentUser() {
  return _auth.currentUser;
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? userId; // User ID indicator

  @override
  void initState() {
    super.initState();
    userId = getCurrentUserId();
  }

  String? getCurrentUserId() {
    User? user = FirebaseAuth.instance.currentUser;
    return user?.uid;
  }

  // List to keep track of tapped notes
  List<bool> isNoteTappedList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Notes', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.lightBlueAccent, // Blue-themed AppBar
        actions: [
          if (userId != null)
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'User ID: $userId',
                style: TextStyle(fontSize: 16.0, color: Colors.white),
              ),
            ),
        ],
      ),
      body: SingleChildScrollView(
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('notes')
              .where('userId', isEqualTo: userId)
              .snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }

            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return Center(child: Text('No notes found.'));
            }

            // Initialize the list of tapped notes
            isNoteTappedList =
                List.generate(snapshot.data!.docs.length, (index) => false);

            return ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                DocumentSnapshot note = snapshot.data!.docs[index];

                Map<String, dynamic> data = note.data() as Map<String, dynamic>;

                String title = data['title'] ?? 'No Title';

                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => NoteDetailPage(
                          noteContent: data['content'],
                          noteTitle: title,
                          timestamp: data['timestamp'],
                        ),
                      ),
                    );
                  },
                  onLongPress: () {
                    setState(() {
                      isNoteTappedList[index] = !isNoteTappedList[index];
                    });
                  },
                  child: ListTile(
                    title: Text(title,
                        style: TextStyle(
                            color: Colors.blueAccent)), // Blue-themed text
                    subtitle: isNoteTappedList[index]
                        ? Text(data['content'])
                        : Text(
                            data['content'].split('\n').first,
                            overflow: TextOverflow.ellipsis,
                          ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit, color: Colors.blueAccent),
                          onPressed: () {
                            // Navigate to the NoteEditPage
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => NoteEditPage(
                                  noteId: note.id,
                                  initialContent: data['content'],
                                  initialTitle: data['title'],
                                ),
                              ),
                            );
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete,
                              color: const Color.fromARGB(255, 0, 0, 0)),
                          onPressed: () => note.reference.delete(),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => AddNotePage()));
        },
        child: Icon(Icons.add, color: Colors.white), // Keep icon color
        backgroundColor: Colors.lightBlueAccent, // Blue-themed FAB background
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.lightBlueAccent, // Blue-themed BottomAppBar
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
            ),
          ],
        ),
      ),
      backgroundColor: Colors.lightBlue[50],
    );
  }
}
