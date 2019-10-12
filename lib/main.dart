import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';



void main() => runApp(new MaterialApp(
  home: Home(),
));

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  var _textField = new TextEditingController();
  String _sharedPrefData = '';
  

  void _loadSharedPrefs() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      if(preferences.getString('data') != null &&
        preferences.getString('data').isNotEmpty
      ) {
        _sharedPrefData = preferences.getString('data');
      } else {
        _sharedPrefData = 'No Data was saved!';
      }
    });
  }
  

  void _saveSharedPrefs(String message) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('data', message);
  }



  @override
  void initState() {
    super.initState();
    _loadSharedPrefs();
  }
  
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Persisting Data Part 2')
      ),

      body: Container (
        alignment: Alignment.topCenter,
        child: ListTile(
          title: Column(
            children: <Widget> [
              Padding(padding: EdgeInsets.all(12.0)),

              Text("Your Text Will Be Displayed Here!!!",
                style: TextStyle(fontSize: 16.0)),

              Padding(padding: EdgeInsets.all(12.0)),

              Text(_sharedPrefData, style: TextStyle(fontSize: 16.0)),

              Padding(padding: EdgeInsets.all(12.0)),

              TextField(
                controller: _textField,
                decoration: InputDecoration(
                  labelText: 'Enter some text'
                )
              ),

              Padding(padding: EdgeInsets.all(12.0)),

              MaterialButton(
                minWidth: 280.0,
                color: Colors.blue,
                textColor: Colors.white,
                onPressed: () {
                  if(_textField.text.isEmpty) {
                    _showErrorToast();
                  } else {
                    _saveSharedPrefs(_textField.text);
                  }
                },
                child: Text("Save Data")
              )
            ]
          )
        )
      )

      
    );
  }
  void _showErrorToast() {
    Fluttertoast.showToast(
      msg: 'Please enter text',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM
    );
  }
  
}