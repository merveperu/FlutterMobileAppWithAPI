import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:healthination_flutterapp/main.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'sidemenu.dart';
import 'package:google_fonts/google_fonts.dart';

class Third extends StatefulWidget {
  const Third({super.key});

  @override
  State<Third> createState() => _ThirdState();
}

List orders = [];

class _ThirdState extends State<Third> {
  //display orders with api
  Future fetchOrders() async {
    var response = await http.get(
        Uri.parse("https://backend.gohealthination.com/orders/"),
        headers: { 
           'Authorization': 'Bearer $myToken',});
           print('Token : ${myToken}');

    if (response.statusCode == 200) {
      print("Connection for displaying orders succesful.");
      print(response.statusCode);
      var items = json.decode(utf8.decode(response.bodyBytes))["results"];

      print(items);
      setState(() {
        orders = items;
      });
    } else {
      print("Connection for displaying orders is not succesful.");
      print(response.statusCode);
      setState(() {
        orders = [];
      });
    }
    ;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.fetchOrders();
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
            padding: const EdgeInsets.only(left: 30.0),
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
          child: Stack(
            children: [
              ListView.builder(
                  itemCount: orders.length,
                  itemBuilder: (context, index) {
                    //variables
                    String id = orders[index]["order"].toString();
                    print(id);
                    return Padding(
                      padding:
                          const EdgeInsets.only(top: 10.0, left: 10, right: 10),
                      child: Row(
                        children: [
                          Expanded(
                              child: SizedBox(
                            width: 20,
                            height: 130,
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Color.fromARGB(255, 203, 197, 197),
                                    Color.fromARGB(134, 255, 255, 255)
                                  ],
                                  begin: Alignment.bottomLeft,
                                  end: Alignment.bottomLeft,
                                ),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 0.0),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 80,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(5),
                                              bottomLeft: Radius.circular(5)),
                                          color:
                                              Color.fromARGB(255, 26, 72, 150)),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Column(
                                            children: [
                                              Text(
                                                "aa",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 12,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 20,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    "aa",
                                                    style: TextStyle(
                                                      color: Color.fromARGB(
                                                          184, 255, 255, 255),
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                  Text(
                                                    "aa",
                                                    style: TextStyle(
                                                      color: Color.fromARGB(
                                                          184, 255, 255, 255),
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 20,
                                              ),
                                              Text(
                                                "aa",
                                                style: TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 255, 255, 255),
                                                  fontSize: 11,
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                              Text(
                                                "aa",
                                                style: TextStyle(
                                                    color: Color.fromARGB(
                                                        184, 255, 255, 255),
                                                    fontSize: 12),
                                                textAlign: TextAlign.center,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ))
                        ],
                      ),
                    );
                  })
            ],
          ),
        ),
      ),
    );
  }
}
