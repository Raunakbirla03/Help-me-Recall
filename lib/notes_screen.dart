import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:counter/note_editor.dart';
import 'package:counter/note_reader.dart';
import 'package:flutter/material.dart';
import 'package:counter/note_card.dart';

class NotesScreen extends StatefulWidget {
  const NotesScreen({Key? key}) : super(key: key);

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  @override
  Widget build(BuildContext context) {
    var cardTextStyle1 = TextStyle(
        fontFamily: "Montserrat Regular", fontSize: 22.0, color: Colors.black);
    var cardTextStyle2 = TextStyle(
        fontFamily: "Montserrat Regular", fontSize: 18.0, color: Colors.black);
    var cardTextStyle3 = TextStyle(
        fontFamily: "Montserrat Regular",
        fontSize: 22.0,
        color: Colors.white,
        fontWeight: FontWeight.bold);
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text("Notes", style: cardTextStyle3),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Your recent Notes",
              style: cardTextStyle2,
            ),
            SizedBox(
              height: 20.0,
            ),
            Expanded(
                child: StreamBuilder<QuerySnapshot>(
              stream:
                  FirebaseFirestore.instance.collection("Notes").snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (snapshot.hasData) {
                  return GridView(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2),
                    children: snapshot.data!.docs
                        .map((note) => noteCard(() {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        NoteReaderScreen(note),
                                  ));
                            }, note))
                        .toList(),
                  );
                }
                return Text(
                  "There are no notes ",
                  style: cardTextStyle2,
                );
              },
            ))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => NoteEditorScreen()));
        },
        label: Text("Add Note"),
        icon: Icon(Icons.add),
      ),
    );
  }
}
