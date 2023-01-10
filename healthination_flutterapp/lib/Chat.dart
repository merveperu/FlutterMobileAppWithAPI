import 'package:healthination_flutterapp/Active.dart';
import 'package:healthination_flutterapp/main.dart';

import 'sidemenu.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:google_fonts/google_fonts.dart';
import 'package:getwidget/getwidget.dart';
import 'package:http/http.dart' as http;
import 'Active.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  List users = [];

  String fullname = "";
  String myFullName = myFirstName + " " + myLastName;
  Future fetchUser() async {
    var response = await http.get(Uri.parse(
        "https://backend.gohealthination.com/users/user_list/?is_staff=True&page_size=50"));
    if (response.statusCode == 200) {
      print("Connection for displaying staff chat succesful.");
      var items = json.decode(utf8.decode(response.bodyBytes))["results"];
      //10 kişiden sonra kimse yok görünüyor!
      //print(items);
      setState(() {
        users = items;
      });
    } else {
      print("Connection for displaying staff chat is not succesful.");
      setState(() {
        users = [];
      });
    }
    ;
  }

  void initState() {
    // TODO: implement initState
    super.initState();
    this.fetchUser();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Chat",
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 40.0),
                        child: SizedBox(
                          width: 300,
                          height: 60,
                          child: GFButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Active(),
                                  ));
                            },
                            //here, instead of users, display staff!!--------------------------!!!!!display staff here not quote form users!!
                            text: "Active Conversations",

                            textColor: Color.fromARGB(255, 255, 255, 255),

                            shape: GFButtonShape.pills,
                            color: Color.fromARGB(255, 84, 102, 168),
                            fullWidthButton: true,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          width: 300,
                          height: 60,
                          child: GFButton(
                            onPressed: () {},
                            //here, instead of users, display staff!!--------------------------!!!!!display staff here not quote form users!!
                            text: "All Conversations",

                            textColor: Color.fromARGB(255, 255, 255, 255),

                            shape: GFButtonShape.pills,
                            color: Color.fromARGB(255, 84, 102, 168),
                            fullWidthButton: true,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 220.0),
                child: ListView.builder(
                    itemCount: users.length,
                    itemBuilder: (context, index) {
                      var my_visibility=true;
                      
                      fullname = users[index]["full_name"];
                      if(fullname==myFullName){
                        my_visibility=false;
                      }
                      //The current user's name will not show on the screen with Visibility Widget! Done
                      return Visibility(
                        visible: my_visibility,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          //centers the screen
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 300,
                                  height: 60,
                                  child: GFButton(
                                    onPressed: () {
                                      setState(() {});
                                    },
                                    text: fullname,
                                    textColor: Color.fromARGB(255, 75, 32, 177),
                                    shape: GFButtonShape.pills,
                                    color: Color.fromARGB(255, 84, 102, 168),
                                    fullWidthButton: true,
                                    type: GFButtonType.outline2x,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
              ),
            ]),
          )),
    );
  }
}
