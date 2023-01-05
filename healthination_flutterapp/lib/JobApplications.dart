import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'sidemenu.dart';
import 'package:google_fonts/google_fonts.dart';

class JopApplications extends StatefulWidget {
  const JopApplications({super.key});

  @override
  State<JopApplications> createState() => _JopApplicationsState();
}

//Global Text Style
class MyTextStyle {
  static const TextStyle textStyle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w300,
    color: Color.fromARGB(255, 10, 55, 117),
  );
}

//Global Text Style2
class MyTextStyle2 {
  static const TextStyle textStyle = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w200,
    color: Color.fromARGB(149, 15, 39, 124),
  );
}

//Global Text Style3 for showdialog texts
class MyTextStyle3 {
  static const TextStyle textStyle = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w200,
    color: Color.fromARGB(255, 15, 39, 124),
  );
}

//Global Text Style3 for showdialog headers
class MyTextStyle4 {
  static const TextStyle textStyle = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w200,
    color: Color.fromARGB(255, 15, 39, 124),
    decoration: TextDecoration.underline,
  );
}

class _JopApplicationsState extends State<JopApplications> {
  String jobs = "";

  List users = [];
  bool isLoading = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.fetchJob();
  }

//delete job application users with api
  Future deleteJob(int id) async {
    final response = await http.delete(
      Uri.parse(
          "https://backend.gohealthination.com/additions/job_application/$id/"),
    );
    //204 olunca da sildi ben de bunu ekledim
    if (response.statusCode == 200 || response.statusCode == 204) {
      print("Connection for delete job application users succesful!");
      //var items = json.decode(utf8.decode(response.bodyBytes))["id"];
      //print(response.body);
    } else {
      print(
          'Connection for delete job application users not succesful! Response code:');
      print(response.statusCode);
    }
  }

  //display job applications with api
  Future fetchJob() async {
    var response = await http.get(Uri.parse(
        "https://backend.gohealthination.com/additions/job_application/"));
    json.decode(utf8.decode(response.bodyBytes));
    if (response.statusCode == 200) {
      print("Connection for displaying job application users succesful.");
      var items = json.decode(utf8.decode(response.bodyBytes))["results"];
      //print(items);
      setState(() {
        users = items;
      });
    } else {
      print(
          "Connection for displaying job application users is not succesful. Status Code:");
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
          color: Color.fromARGB(137, 26, 51, 150),  
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
              Padding(
                padding: const EdgeInsets.only(top: 25.0, left: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(users.length.toString(),
                            style: TextStyle(
                              color: Color.fromARGB(255, 255, 255, 255),
                              fontWeight: FontWeight.w300,
                              fontSize: 17,
                            )),
                        Text(
                          "Total Job Applications",
                          style: TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontWeight: FontWeight.w200,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 80.0, bottom: 3),
                child: ListView.builder(
                  itemCount: users.length,
                  itemBuilder: (context, index) {
                    //date variables
                    String time = users[index]["created_at"];
                    DateTime dateTime = DateTime.parse(time);

                    //user role variables
                    String job = users[index]["job"];
                    if (job == "HO") {
                      job = "Hospitality Organizer";
                    } else if (job == "Ac") {
                      job = "Accountant";
                    } else if (job == "CC") {
                      job = "Call Center";
                    } else if (job == "TO") {
                      job = "Travel Organizer";
                    } else if (job == "HO") {
                      job = "Hospitality Organizer";
                    } else if (job == "Tr") {
                      job = "Translator";
                    } else {
                      job = "Site Manager";
                    }

                    return Padding(
                      padding:
                          const EdgeInsets.only(top: 10.0, left: 10, right: 10),

                      //Each of the cards
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
                                      Color.fromARGB(255, 159, 154, 154),
                                      Color.fromARGB(134, 255, 255, 255)
                                    ],
                                    begin: Alignment.bottomLeft,
                                    end: Alignment.bottomLeft,
                                  ),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Padding(
                                  //Text paddings inside cards. If i set this, left side does not fill all the area.
                                  padding: const EdgeInsets.only(left: 0.0),
                                  child: Row(
                                    children: [
                                      Row(
                                        children: [
                                          //Left Side Starts From Here!
                                          Container(
                                            width: 80,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.only(
                                                    topLeft: Radius.circular(5),
                                                    bottomLeft:
                                                        Radius.circular(5)),
                                                color: Color.fromARGB(
                                                    255, 26, 72, 150)),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Column(
                                                  children: [
                                                    Text(
                                                      DateFormat.Hm()
                                                          .format(dateTime),
                                                      style: TextStyle(
                                                        color: Color.fromARGB(
                                                            255, 255, 255, 255),
                                                        fontSize: 11,
                                                      ),
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                    Text(
                                                      DateFormat.yMd()
                                                          .format(dateTime),
                                                      style: TextStyle(
                                                          color: Color.fromARGB(
                                                              184,
                                                              255,
                                                              255,
                                                              255),
                                                          fontSize: 12),
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                    IconButton(
                                                      icon: Icon(Icons.info),
                                                      iconSize: 24.0,
                                                      color: Color.fromARGB(
                                                          184, 255, 255, 255),
                                                      onPressed: () {
                                                        showDialog(
                                                            context: context,
                                                            builder:
                                                                (BuildContext
                                                                    context) {
                                                              return AlertDialog(
                                                                scrollable:
                                                                    true,
                                                                content: Row(
                                                                  children: [
                                                                    Row(
                                                                        children: [
                                                                          Padding(
                                                                            padding:
                                                                                const EdgeInsets.only(left: 2.0),
                                                                            child:
                                                                                SizedBox(
                                                                              width: 230,
                                                                              child: Column(
                                                                                //center horizontally
                                                                                mainAxisAlignment: MainAxisAlignment.center,
                                                                                //fixes to the left
                                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                                children: [
                                                                                  Text(
                                                                                    "Applicant: ",
                                                                                    style: MyTextStyle4.textStyle,
                                                                                  ),
                                                                                  Row(
                                                                                    children: [
                                                                                      Text(
                                                                                        users[index]["name"],
                                                                                        style: MyTextStyle3.textStyle,
                                                                                        softWrap: false,
                                                                                        maxLines: 1,
                                                                                        overflow: TextOverflow.ellipsis,
                                                                                      ),
                                                                                      Text(" "),
                                                                                      Text(
                                                                                        users[index]["surname"],
                                                                                        style: MyTextStyle3.textStyle,
                                                                                        softWrap: false,
                                                                                        maxLines: 1,
                                                                                        overflow: TextOverflow.ellipsis,
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                  SizedBox(
                                                                                    height: 10,
                                                                                  ),
                                                                                  Text(
                                                                                    "Applied Role: ",
                                                                                    style: MyTextStyle4.textStyle,
                                                                                    softWrap: false,
                                                                                    maxLines: 20,
                                                                                    overflow: TextOverflow.ellipsis,
                                                                                  ),
                                                                                  Text(
                                                                                    job,
                                                                                    style: MyTextStyle3.textStyle,
                                                                                    softWrap: false,
                                                                                    maxLines: 20,
                                                                                    overflow: TextOverflow.ellipsis,
                                                                                  ),
                                                                                  SizedBox(
                                                                                    height: 10,
                                                                                  ),
                                                                                  Column(
                                                                                    //center horizontally
                                                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                                                    //fixes to the left
                                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                                    children: [
                                                                                      Text(
                                                                                        "Introduction Text:",
                                                                                        style: MyTextStyle4.textStyle,
                                                                                      ),
                                                                                      Text(
                                                                                        users[index]["introduce"],
                                                                                        style: MyTextStyle3.textStyle,
                                                                                        softWrap: false,
                                                                                        maxLines: 20,
                                                                                        overflow: TextOverflow.ellipsis,
                                                                                      ),
                                                                                      SizedBox(
                                                                                        height: 40,
                                                                                      ),
                                                                                      MaterialButton(
                                                                                          minWidth: 120,
                                                                                          color: Color.fromARGB(255, 26, 72, 150),
                                                                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                                                                                          child: Padding(
                                                                                            padding: const EdgeInsets.all(8.0),
                                                                                            child: Text(
                                                                                              "Accept as a\n" + job,
                                                                                              style: TextStyle(color: Colors.white),
                                                                                              textAlign: TextAlign.center,
                                                                                            ),
                                                                                          ),
                                                                                          onPressed: () {
                                                                                            setState(() {});
                                                                                          }),
                                                                                    ],
                                                                                  ),
                                                                                  MaterialButton(
                                                                                      minWidth: 100,
                                                                                      color: Color.fromARGB(255, 195, 35, 35),
                                                                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                                                                                      child: Text(
                                                                                        "Reject and delete",
                                                                                        style: TextStyle(color: Colors.white),
                                                                                        textAlign: TextAlign.center,
                                                                                      ),
                                                                                      onPressed: () {
                                                                                        deleteJob(users[index]["id"]);
                                                                                      }),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ]),
                                                                  ],
                                                                ),
                                                              );
                                                            });
                                                      },
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      //Right Side Starts From Here!
                                      //right sides's left column
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10.0),
                                        child: SizedBox(
                                          width: 75,
                                          child: Column(
                                            //center horizontally
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            //fixes to the left
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "NAME:",
                                                style: MyTextStyle2.textStyle,
                                              ),
                                              Text(
                                                "POSITION:",
                                                style: MyTextStyle2.textStyle,
                                              ),
                                              Text(
                                                "INTRODUCE:",
                                                style: MyTextStyle2.textStyle,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),

                                      //right side's right column
                                      Expanded(
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 15.0),
                                          child: Column(
                                            //center horizontally
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            //fixes to the left
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Text(
                                                    users[index]["name"],
                                                    style:
                                                        MyTextStyle.textStyle,
                                                    softWrap: false,
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                  Text(" "),
                                                  Text(
                                                    users[index]["surname"],
                                                    style:
                                                        MyTextStyle.textStyle,
                                                    softWrap: false,
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ],
                                              ),
                                              Text(
                                                users[index]["job"],
                                                style: MyTextStyle.textStyle,
                                                softWrap: false,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              Text(
                                                users[index]["introduce"],
                                                style: MyTextStyle.textStyle,
                                                softWrap: false,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      //delete button
                                      IconButton(
                                        icon: Icon(Icons.delete),
                                        iconSize: 24.0,
                                        color: Color.fromARGB(199, 26, 71, 150),
                                        onPressed: () {
                                          print(users[index]["id"]);

                                          setState(() {
                                            deleteJob(users[index]["id"]);
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      const JopApplications(),
                                                ));
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
