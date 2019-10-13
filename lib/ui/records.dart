import 'package:flutter/material.dart';
import 'package:teacher/model/student.dart';
import 'package:teacher/ui/edit.dart';
import 'package:teacher/ui/entry.dart';
import 'package:teacher/utils/database_helper.dart';

class Records extends StatefulWidget {
  Records({Key key}) : super(key: key);

  _RecordsState createState() => _RecordsState();
}

class _RecordsState extends State<Records> {

  final List<Student> _studentRecords = <Student>[];
  var db = new DatabaseHelper();

  @override
  void initState() {
    super.initState();
    _readDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      
        body: Column(children: <Widget>[
          Flexible (
            child: ListView.builder(
              padding: EdgeInsets.all(8.0),
              reverse: false,
              itemCount: _studentRecords.length,
              itemBuilder: (_, int index) {
                return Card (
                  child: ListTile(
                    title: Text(_studentRecords[index].firstName), 
                    onLongPress: () => _editStudent(_studentRecords[index], index),
                    trailing: Listener(
                      key: Key(_studentRecords[index].firstName),
                      child: Icon(Icons.remove_circle, color: Colors.red),
                      onPointerDown: (pointerEvent) => _deleteStudent(_studentRecords[index].id, index),
                    )
                  )
                );
              }
            )
          )
        ],),
      
      
      
      
       floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.purple,
          child: ListTile(
            title: Icon(Icons.add, color: Colors.white),

          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Entry()),
            );
          }
       )
    );
  }


  void _readDatabase() async {
    List studentInfo = await db.getStudentRecords();
    studentInfo.forEach((studentInfoItem) {
      Student student = Student.fromMap(studentInfoItem);
      setState(() {
        _studentRecords.add(student);
      });
    });
  }


  void _deleteStudent(int id, int index) async{
    await db.deleteRecord(id);
    setState(() {
      _studentRecords.removeAt(index);
    });
  }

  void _editStudent(Student student, int index) async {
    student = _studentRecords[index];
    var route = MaterialPageRoute(builder: (BuildContext context) => Edit(student:student));
    Navigator.of(context).push(route);
  }
}