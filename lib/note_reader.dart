import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class NoteReaderScreen extends StatefulWidget {
  NoteReaderScreen(this.doc, {Key? key}) : super(key: key);
  QueryDocumentSnapshot doc;

  @override
  State<NoteReaderScreen> createState() => _NoteReaderScreenState();
}

class _NoteReaderScreenState extends State<NoteReaderScreen> {
  @override
  Widget build(BuildContext context) {
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
        backgroundColor: cardsColor[color_id],
        elevation: 0.0,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.doc["note_title"],
              style: cardTextStyle1,
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
            Text(
              widget.doc["note_content"],
              style: cardTextStyle2,
            ),
          ],
        ),
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
