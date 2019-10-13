import 'package:flutter/material.dart';

class Student{
  String _firstName;
  String _lastName;
  String _contactNumber;
  int _id;

  Student(this._firstName, this._lastName, this._contactNumber);

  String get firstName => _firstName;
  String get lastName => _lastName;
  String get contactNumber => _contactNumber;
  int get id => _id;


  Student.fromMap(Map<String, dynamic> map) {
    this._firstName = map['firstName'];
    this._lastName = map['lastName'];
    this._contactNumber = map['contactNumber'];
    this._id = map['id'];
  }

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map['firstName'] = _firstName;
    map['lastName'] = _lastName;
    map['contactNumber'] = _lastName;

    if(id != null) {
      map['id'] = _id;
    }

    return map;
  }

  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget> [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget> [
              Text("{$_lastName.toUpperCase()}, $_firstName",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16.0,
                  fontFamily: 'Roboto'
                ),
              ),

              Text("$_contactNumber",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14.0,
                  fontFamily: 'Roboto',
                  fontStyle: FontStyle.italic
                )
              )
              
            ],
          )
        ]
      )
    );
  }
}