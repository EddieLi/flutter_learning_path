import 'package:flutter/material.dart';

class CreateProfile extends StatefulWidget {
  CreateProfile({Key key}) : super(key: key);

  _CreateProfileState createState() => _CreateProfileState();
}

class _CreateProfileState extends State<CreateProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create a Profile"),
        backgroundColor: Colors.deepPurple
      ),

      body: Stack(
        children: <Widget> [
          Form(
            child: ListView(
              children: <Widget> [
                TextFormField(
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    hintText: 'Enter a User Name',
                    contentPadding: const EdgeInsets.all(20.0),
                    labelText: 'User Name'
                  )
                ),

                TextFormField(
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    hintText: 'you@example.com',
                    contentPadding: const EdgeInsets.all(20.0),
                    labelText: 'Email Address'
                  )
                ),

              ],
            ),)
        ],
      )
    );
  }
}