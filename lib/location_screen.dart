import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:geocoder/geocoder.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({Key? key}) : super(key: key);

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  @override
  Widget build(BuildContext context) {
    String myAddress = ' ';
    TextEditingController _addressController = TextEditingController();
    var cardTextStyle3 = TextStyle(
        fontFamily: "Montserrat Regular",
        fontSize: 22.0,
        color: Colors.white,
        fontWeight: FontWeight.bold);
    var cardTextStyle0 = TextStyle(
        fontFamily: "Montserrat Regular",
        fontSize: 20.0,
        color: Colors.black,
        fontWeight: FontWeight.normal);

    getAddress() async {
      SharedPreferences pref = await SharedPreferences.getInstance();
      String localAddress = pref.getString('localValue') ?? '';
      return localAddress;
    }

    setAddress() async {
      SharedPreferences pref = await SharedPreferences.getInstance();
      pref.setString('localValue', myAddress);
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text("Take Me Home", style: cardTextStyle3),
        centerTitle: false,
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 44.0,
            ),
            TextFormField(
              maxLines: 4,
              keyboardType: TextInputType.streetAddress,
              decoration: InputDecoration(
                helperText: "",
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 2, color: Colors.blueAccent),
                  borderRadius: BorderRadius.circular(20.0),
                ),
                label: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.home, size: 27.0, color: Colors.black),
                    const SizedBox(
                      width: 10.0,
                    ),
                    Text("Enter Address", style: cardTextStyle0),
                  ],
                ),
              ),
              onChanged: (String newText) {
                if (newText.isNotEmpty) {
                  SemanticsService.announce(
                      '\$' + newText, Directionality.of(context));
                }
                myAddress = newText;
              },
            ),
            const SizedBox(
              height: 34.0,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              child: RawMaterialButton(
                fillColor: const Color(0xFF0069FE),
                elevation: 0.0,
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0)),
                onPressed: () async {
                  var addresses =
                      await Geocoder.local.findAddressesFromQuery(myAddress);
                  var first = addresses.first;
                  print("${first.featureName} : ${first.coordinates}");
                  MapsLauncher.launchCoordinates(
                      first.coordinates.latitude, first.coordinates.longitude);
                },
                child: const Text("Get Directions",
                    style: TextStyle(
                      fontFamily: "Montserrat Regular",
                      color: Colors.white,
                      fontSize: 18.0,
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
