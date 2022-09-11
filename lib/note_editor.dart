import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class NoteEditorScreen extends StatefulWidget {
  const NoteEditorScreen({Key? key}) : super(key: key);

  @override
  State<NoteEditorScreen> createState() => _NoteEditorScreenState();
}

class _NoteEditorScreenState extends State<NoteEditorScreen> {
  int color_id = Random().nextInt(cardsColor.length);
  String date = DateTime.now().toString();
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
  TextEditingController _titleController = TextEditingController();
  TextEditingController _mainController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cardsColor[color_id],
      appBar: AppBar(
        backgroundColor: cardsColor[color_id],
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          "Add a new Note",
          style: TextStyle(
              fontFamily: "Montserrat Regular",
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Note Title',
              ),
              style: cardTextStyle1,
            ),
            SizedBox(
              height: 8.0,
            ),
            Text(
              date,
              style: cardTextStyle3,
            ),
            SizedBox(
              height: 28.0,
            ),
            TextField(
              controller: _mainController,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Note Content',
              ),
              style: cardTextStyle2,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFF0065FF),
        onPressed: () async {
          FirebaseFirestore.instance.collection("Notes").add({
            "note_title": _titleController.text,
            "creation_date": date,
            "note_content": _mainController.text,
            "color_id": color_id
          }).then((value) {
            print(value.id);
            Navigator.pop(context);
          }).catchError(
              (error) => print("Failed to add a new note due to $error"));
        },
        child: Icon(Icons.save),
      ),
    );
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
