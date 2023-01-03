import 'dart:convert';

import 'package:flutter_social_button/flutter_social_button.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'sidemenu.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class Third extends StatefulWidget {

  const Third({super.key});

  @override
  State<Third> createState() => _ThirdState();
}

List users = [];
class _ThirdState extends State<Third> {



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.fetchUser();
  }
  //display all users with api
  Future fetchUser() async {
    var response = await http.get(
        Uri.parse("https://backend.gohealthination.com/users/user_list/?is_staff=True"));
    if (response.statusCode == 200  || response.statusCode == 201 || response.statusCode == 204) {
      print("Connection for displaying all users succesful.");
      final map= json.decode(utf8.decode(response.bodyBytes)); 
      print(map);   
    } else {
      print("Connection for displaying all users is not succesful.");
      print(response.statusCode);
      setState(() {
        users = [];
      });
    }
    ;
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Patient Process",
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
              padding: const EdgeInsets.only(left:30.0),
              child: SizedBox(width: 150, child: Image.asset("assets/logo.png")),
            ),
          ),
        body: Container(
          decoration: BoxDecoration(
              gradient: new LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color.fromARGB(105, 51, 28, 142),
              Color.fromARGB(139, 35, 171, 96)
            ],
          )),
        ),
      ),
    );
  }
}