import 'sidemenu.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:google_fonts/google_fonts.dart';
import 'package:getwidget/getwidget.dart';
import 'package:http/http.dart' as http;

class Active extends StatefulWidget {
  const Active({super.key});

  @override
  State<Active> createState() => _ActiveState();
}

class _ActiveState extends State<Active> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.fetchChat();
  }

  List chats = [];
  //display chat with api
  Future fetchChat() async {
    try {
      
      var response = await http
          .get(Uri.parse("https://backend.gohealthination.com/chat/messages/"));
          
      print(response.statusCode);
      if(response.body.isNotEmpty){
        print(json.decode(response.body));
      }

      // if (response.statusCode == 200) {
      //   print("Connection for displaying job application users succesful.");
      //   var items = await response.bodyBytes;
      //   print(items);

      //   setState(() {
      //     chats = items;
      //   });
      // } else {
      //   print(
      //       "Connection for displaying job application users is not succesful. Status Code:");
      //   print(response.statusCode);
      //   setState(() {
      //     chats = [];
      //   });
      // }
    } catch (e) {
      print(e);
    }
    ;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Active Conversations",
      theme: ThemeData(
        textTheme: GoogleFonts.latoTextTheme(
          Theme.of(context).textTheme,
        ),
        primarySwatch: Colors.blue,
        appBarTheme: AppBarTheme(
          iconTheme: IconThemeData(color: Colors.black),
          color: Color.fromARGB(137, 26, 51, 150), //<-- SEE HERE
        ),
      ),
      home: Scaffold(
          drawer: NavDrawer(),
          appBar: AppBar(
            iconTheme: IconThemeData(color: Color.fromARGB(160, 255, 255, 255)),
            title: Padding(
              padding: const EdgeInsets.only(left: 30.0),
              child:
                  SizedBox(width: 150, child: Image.asset("assets/logo.png")),
            ),
          ),
          body: Container(
            decoration: BoxDecoration(
                gradient: new LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color.fromARGB(158, 133, 115, 204),
                Color.fromARGB(137, 101, 198, 144)
              ],
            )),
            child: Stack(children: [
              Padding(
                padding: const EdgeInsets.only(top: 220.0),
                child: ListView.builder(
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        //centers the screen
                        child: Center(
                          child: Row(),
                        ),
                      );
                    }),
              ),
            ]),
          )),
    );
  }
}
