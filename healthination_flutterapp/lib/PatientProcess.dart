import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'sidemenu.dart';

class Third extends StatefulWidget {
  const Third({super.key});

  @override
  State<Third> createState() => _ThirdState();
}

class _ThirdState extends State<Third> {
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