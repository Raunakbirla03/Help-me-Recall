import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:counter/notes_screen.dart';
import 'package:counter/note_editor.dart';

class NoteReaderScreen extends StatefulWidget {
  NoteReaderScreen(this.doc, {Key? key}) : super(key: key);
  QueryDocumentSnapshot doc;

  @override
  State<NoteReaderScreen> createState() => _NoteReaderScreenState();
}

class _NoteReaderScreenState extends State<NoteReaderScreen> {
  late TextEditingController _titleController;
  late TextEditingController _mainController;
  @override
  void initState() {
    _titleController = TextEditingController(text: widget.doc['note_title']);
    _mainController = TextEditingController(text: widget.doc['note_content']);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String date = DateTime.now().toString();
    int color_id = widget.doc['color_id'];
    var cardTextStyle1 = TextStyle(
        fontFamily: "Montserrat Regular",
        fontSize: 18.0,
        fontWeight: FontWeight.bold);
    var cardTextStyle2 = TextStyle(
        fontFamily: "Montserrat Regular",
        fontSize: 16.0,
        fontWeight: FontWeight.normal);
    var cardTextStyle3 = TextStyle(
        fontFamily: "Montserrat Regular",
        fontSize: 13.0,
        fontWeight: FontWeight.w500);
    return Scaffold(
        backgroundColor: cardsColor[color_id],
        appBar: AppBar(
          leading: const BackButton(
            color: Colors.black,
          ),
          backgroundColor: cardsColor[color_id],
          elevation: 0.0,
        ),
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: _titleController,
                style: cardTextStyle1,
                decoration: new InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Note Title',
                ),
              ),
              SizedBox(
                height: 13.0,
              ),
              Text(
                widget.doc["creation_date"],
                style: cardTextStyle3,
              ),
              SizedBox(
                height: 28.0,
              ),
              TextField(
                maxLines: null,
                controller: _mainController,
                style: cardTextStyle2,
                decoration: new InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Note Content',
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(left: 30),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              FloatingActionButton(
                backgroundColor: Colors.red,
                onPressed: () async {
                  final docUser = FirebaseFirestore.instance
                      .collection('Notes')
                      .doc(widget.doc.id);
                  docUser.delete();
                  Navigator.pop(context,
                      MaterialPageRoute(builder: (context) => NotesScreen()));
                },
                heroTag: "gaandu",
                child: Icon(Icons.delete),
              ),
              Expanded(child: Container()),
              FloatingActionButton(
                backgroundColor: Color(0xFF0065FF),
                onPressed: () async {
                  FirebaseFirestore.instance
                      .collection("Notes")
                      .doc(widget.doc.id)
                      .update({
                    "note_title": _titleController.text,
                    "creation_date": date,
                    "note_content": _mainController.text,
                    "color_id": color_id
                  }).then((value) {
                    //print(value.id);
                    Navigator.pop(context);
                  }).catchError((error) =>
                          print("Failed to add a new note due to $error"));
                },
                child: Icon(Icons.save),
              ),
            ],
          ),
        ));
  }
}

List<Color> cardsColor = [
  Colors.purple,
  Colors.red.shade100,
  Colors.pink.shade100,
  Colors.orange.shade100,
  Colors.yellow.shade100,
  Colors.green.shade100,
  Colors.blue.shade100,
  Colors.blueGrey.shade100,
];
