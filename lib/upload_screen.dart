import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'package:dio/dio.dart';

class UploadScreen extends StatefulWidget {
  const UploadScreen({Key? key}) : super(key: key);

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  int _counter = 0;
  XFile? _image;
  final GlobalKey<ScaffoldState> _scaffoldstate =
      new GlobalKey<ScaffoldState>();

  Future getImage() async {
    var image = await ImagePicker().pickImage(source: ImageSource.gallery);
    _uploadFile(image);

    setState(() {
      _image = image;
    });
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _uploadFile(filePath) async {
    String fileName = basename(filePath.path);
    print("File base name: $fileName");

    try {
      FormData formData = FormData.fromMap({
        "file": await MultipartFile.fromFile(filePath.path, filename: fileName)
      });

      Response response =
          await Dio().post("http://192.168.0.101/saveFile.php", data: formData);
      print("File upload response: ${response.data}");

      _showSnakBarMsg(response.data['message']);
    } catch (e) {
      print("Exception Caught: $e");
    }
  }

  void _showSnakBarMsg(String msg) {
    ScaffoldMessenger.of(this.context)
        .showSnackBar(SnackBar(content: Text(msg)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldstate,
      appBar: AppBar(
        title: Text('Upload Documents'),
      ),
      body: Center(
        child: _image == null
            ? Text('No image selected.')
            : Image.file(File(_image!.path)),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: getImage,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
