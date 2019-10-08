import 'package:flutter/material.dart';

void main() => runApp(new MaterialApp(
  home: BottomNav(),
));

class BottomNav extends StatefulWidget {
  BottomNav({Key key}) : super(key: key);

  _BottomNavState createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    Home(),
    ShareFiles(),
    Chat(),
  ];
  void switchTabs(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Teacher's Corner",
        style: TextStyle(
          fontSize: 30.0
        ))
      ),

      body: _children[_currentIndex],

      bottomNavigationBar: BottomNavigationBar(
        onTap: switchTabs,
        currentIndex: 0,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text("Home"),
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.attach_file),
            title: Text("Share Files"),
          ),


          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text("Chat"),
          )
        ]
      )
    );
  }
}

class Home extends StatelessWidget {
  const Home({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("Home"),
    );
  }
}

class ShareFiles extends StatelessWidget {
  const ShareFiles({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("Share Files"),
    );
  }
}

class Chat extends StatelessWidget {
  const Chat({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("Chat"),
    );
  }
}