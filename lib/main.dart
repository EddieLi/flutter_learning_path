import 'package:flutter/material.dart';
import 'package:teacher/ui/records.dart';
import 'utils/database_helper.dart';
import 'model/student.dart';

void main() async{
  
  runApp(new MaterialApp(
    home: Home(),
    routes: <String, WidgetBuilder> {
      '/home': (BuildContext context) => Home(),
    },
    debugShowCheckedModeBanner: false
  ));
}


class Home extends StatelessWidget {
  const Home({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar (
        centerTitle: false,
        title: Text("StudentRecords",
          style: TextStyle(
            fontSize: 24.0,
            fontFamily: 'Roboto',
            color: Colors.white
          )),
          backgroundColor: Colors.purple,

          
      ),

      body: Records(),
    );
  }
}