import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

Widget noteCard(Function()? onTap, QueryDocumentSnapshot doc) {
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
  return InkWell(
    onTap: onTap,
    child: Container(
      padding: EdgeInsets.all(8.0),
      margin: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: cardsColor[doc['color_id']],
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            doc["note_title"],
            style: cardTextStyle1,
          ),
          SizedBox(
            height: 13.0,
          ),
          Text(
            doc["creation_date"],
            style: cardTextStyle3,
          ),
          SizedBox(
            height: 13.0,
          ),
          Text(
            doc["note_content"],
            style: cardTextStyle2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    ),
  );
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
