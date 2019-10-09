import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import "package:http/http.dart" as http;
import 'package:intl/intl.dart';

var now = new DateTime.now();
var formatter = new DateFormat('yyyy-mm-dd');
String currentDate = formatter.format(now);

// All news bout bitcoin
final String _apiUrl1 = "https://newsapi.org/v2/everything?q=bitcoin&from="
  + currentDate +
"&sortBy=popularity&apiKey=feb98c88495b4f2781002bc3f403ae4e";

// All new about business
final String _apiUrl2 = "https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=feb98c88495b4f2781002bc3f403ae4e";


final String _apiUrl3 = "https://newsapi.org/v2/everything?q=apple&from="
+ currentDate +
"&to="
+ currentDate +
"&sortBy=popularity&apiKey=feb98c88495b4f2781002bc3f403ae4e";


// Variables to store the data
List _provider1;
List _provider2;
List _provider3;

List _provider;
String _headlines = "BitCoin News";


void main() async{
  try {
    _provider1 = await fetchData(_apiUrl1);
    _provider2 = await fetchData(_apiUrl2);
    _provider3 = await fetchData(_apiUrl3);
  } catch (e) {
    print(e);
  }

  _provider = _provider1;
  
  runApp (new MaterialApp(
    home: Home(),
    debugShowCheckedModeBanner: false,
  ));
}

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Container(
       child: Stack(
         fit: StackFit.expand,
         children: <Widget> [
           Image.asset("images/background.jpg", fit: BoxFit.cover,),

           Scaffold(
             drawer: Drawer(
               child: ListView(
                 children: <Widget> [
                   DrawerHeader(
                     child: Text("CHOOSE A NEWS PROVIDER",
                      style: TextStyle(color: Colors.white, fontFamily: 'Times New Roman',
                      fontSize: 18.0),
                     ),
                     decoration: BoxDecoration(color: Colors.blue)
                   ),

                   ListTile(
                     title: Text("Bitcoin News", style: TextStyle(
                       fontFamily: 'Times New Roman', fontSize: 18.0, fontStyle: FontStyle.italic
                     )),
                     subtitle: Text("News Articles Mentioning BitCoin", style: TextStyle(
                       fontFamily: 'Times New Roman', fontSize: 16.0, fontStyle: FontStyle.italic
                     )),

                     onTap: () {
                       setState(() {
                         _provider = _provider1;
                         _headlines = "BitCoin News";
                         Navigator.pop(context);
                       });
                     }
                   ),

                   ListTile(
                     title: Text("Top Business News", style: TextStyle(
                       fontFamily: 'Times New Roman', fontSize: 18.0, fontStyle: FontStyle.italic
                     )),
                     subtitle: Text("News Articles Mentioning Top Business", style: TextStyle(
                       fontFamily: 'Times New Roman', fontSize: 16.0, fontStyle: FontStyle.italic
                     )),
                     
                     onTap: () {
                       setState(() {
                         _provider = _provider2;
                         _headlines = "Top Business News";
                         Navigator.pop(context);
                       });
                     }
                   ),

                    ListTile(
                     title: Text("Apple News", style: TextStyle(
                       fontFamily: 'Times New Roman', fontSize: 18.0, fontStyle: FontStyle.italic
                     )),
                     subtitle: Text("News Articles Mentioning Apple", style: TextStyle(
                       fontFamily: 'Times New Roman', fontSize: 16.0, fontStyle: FontStyle.italic
                     )),
                     
                     onTap: () {
                       setState(() {
                         _provider = _provider3;
                         _headlines = "Apple News";
                         Navigator.pop(context);
                       });
                     }
                   ),


                 ],
               )
             ),
             
             appBar: AppBar(
                centerTitle: true,
                title: Text(_headlines.toUpperCase(),
                  style: TextStyle(fontFamily: 'Times New Roman')),
                elevation: 3.0,
                backgroundColor: Colors.blue.withOpacity(0.5),
             ),
             
             body: Center(
               child: ListView.builder(
                 padding: const EdgeInsets.all(12.0),
                 itemCount: _provider.length,
                 itemBuilder: (BuildContext context, int position) {
                   return Card(
                     child: Column(
                       mainAxisSize: MainAxisSize.min,
                       children: <Widget> [
                         ListTile(
                           title: CachedNetworkImage(
                             imageUrl: "${_provider[position]['urlToImage']}",
                            //  placeholder: CircularProgressIndicator(),
                            //  errorWidget: Icon(Icons.error),
                           ),

                           subtitle: Text("${_provider[position]['title']}",
                            style: TextStyle(fontSize: 16.0,
                            fontWeight: FontWeight.w500,
                            fontFamily: "Times New Roman"),
                           ),
                           onTap: () => _showNewsSnippet(context, _provider[position]['description']),
                           
                         )
                       ]
                     )
                   );
                 },
               ),
             ),

             backgroundColor: Colors.transparent
           )


         ]
       ),
    );
  }
}

// Functions
Future<List>fetchData(String apiUrl) async {
  http.Response response = await http.get(apiUrl);
  return json.decode(response.body)['articles']; 
}

void _showNewsSnippet(BuildContext context, String snippet) {
  var alert = AlertDialog(
    title: Text("Headlines", style: TextStyle(
      fontSize: 16.0, fontFamily: 'Times New Roman', fontWeight: FontWeight.w500
    ),),

    content: Text(snippet),

    actions: <Widget>[
      FlatButton(
        child: Text("Dismiss", style: TextStyle(
          fontSize: 16.0, fontFamily: 'Times New Roman', fontStyle: FontStyle.italic
        )),

        onPressed: () => Navigator.pop(context),
      )
    ],
    
  );


  showDialog(context: context, builder: (context) => alert);
}