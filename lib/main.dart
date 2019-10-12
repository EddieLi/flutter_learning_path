import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'dart:io';
import 'dart:async';

void main() async {
  var data = await readFromFile();

  if (data != null) {
    String message = await readFromFile();
  }


  runApp(new MaterialApp(home: Home()));
}

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var _textField = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Persisting Data Part 1',
            style: TextStyle(fontSize: 20.0),
          ),
        ),
        body: Container(
            alignment: Alignment.topCenter,
            child: ListTile(
                title: Column(children: <Widget>[
              Padding(padding: EdgeInsets.all(12.0)),
              Text("Your Text Will Be Displayed Below!!!",
                  style: TextStyle(fontSize: 16.0)),
              Padding(padding: EdgeInsets.all(12.0)),
              FutureBuilder(
                  future: readFromFile(),
                  builder: (BuildContext context, AsyncSnapshot<String> data) {
                    if (data.hasData != null) {
                      return Text(data.data.toString(),
                          style: TextStyle(
                            fontSize: 24.0,
                          ));
                    } else {
                      return Text("The Text You Entered Goes Here.");
                    }
                  }),
              Padding(
                padding: EdgeInsets.all(12.0),
              ),
              TextField(
                  controller: _textField,
                  decoration: InputDecoration(labelText: 'Enter some text')),
              Padding(padding: EdgeInsets.all(12.0)),
              MaterialButton(
                minWidth: 280.0,
                color: Colors.blue,
                textColor: Colors.white,
                onPressed: () {
                  if (_textField.text.isEmpty) {
                    _showErrorToast();
                  } else {
                    writeToFile(_textField.text);
                  }
                },
                child: Text("Save Data"),
              )
            ]))));
  }
}

Future<String> get _localPath async {
  final directory = await getApplicationDocumentsDirectory();
  return directory.path;
}

Future<File> get _localFile async {
  final path = await _localPath;
  return new File('$path/dartDemo.txt');
}

Future<File> writeToFile(String message) async {
  final file = await _localFile;
  return file.writeAsString(message);
}

Future<String> readFromFile() async {
  try {
    final file = await _localFile;
    return await file.readAsString();
  } catch (e) {
    return "No Files to Read.";
  }
}

void _showErrorToast() {
  Fluttertoast.showToast(
      msg: "Enter text",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.red,
      textColor: Colors.white);
}
