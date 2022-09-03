import 'package:counter/main.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:counter/reminder_screen.dart';
import 'package:counter/upload_screen.dart';
import 'package:counter/notes_screen.dart';
import 'package:counter/location_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  final storage = new FlutterSecureStorage();
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var cardTextStyle = TextStyle(
        fontFamily: "Montserrat Regular", fontSize: 18, color: Colors.black);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: <Widget>[
          Container(
            height: size.height * .5,
            decoration: BoxDecoration(
              image: DecorationImage(
                  alignment: Alignment.topRight,
                  image: AssetImage('assets/top_header.jpg')),
            ),
          ),
          Column(
            children: <Widget>[
              SizedBox(
                height: 220,
              ),
              Padding(
                padding: EdgeInsets.only(left: 16, right: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Welcome to",
                          style: TextStyle(
                              fontFamily: "Montserrat Regular",
                              color: Colors.purple,
                              fontSize: 24,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Text(
                          "Help Me Recall",
                          style: TextStyle(
                              fontFamily: "Montserrat Regular",
                              color: Colors.blueAccent,
                              fontSize: 26,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    IconButton(
                      alignment: Alignment.topCenter,
                      icon: Image.asset(
                        "assets/logout.png",
                        width: 44,
                        height: 44,
                      ),
                      onPressed: () async => {
                        await FirebaseAuth.instance.signOut(),
                        await storage.delete(key: "uid"),
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HomePage(),
                            ),
                            (route) => false)
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Expanded(
                child: GridView.count(
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  primary: false,
                  crossAxisCount: 2,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ReminderScreen()));
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        elevation: 5,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Image.asset(
                              'assets/reminder.png',
                              height: 128,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Reminder',
                              style: cardTextStyle,
                            ),
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => UploadScreen()));
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        elevation: 5,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Image.asset(
                              'assets/folder.png',
                              height: 128,
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Text(
                              'Upload Docs',
                              style: cardTextStyle,
                            ),
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LocationScreen()));
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        elevation: 10,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Image.asset(
                              'assets/map.png',
                              height: 128,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Location',
                              style: cardTextStyle,
                            ),
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => NotesScreen()));
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        elevation: 5,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Image.asset(
                              'assets/notes.png',
                              height: 128,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Notes',
                              style: cardTextStyle,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
