import 'dart:convert';

import 'package:flutter_social_button/flutter_social_button.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'sidemenu.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'AddButton.dart';
import 'QuoteInfo.dart';

class Second extends StatefulWidget {
  const Second({Key? key}) : super(key: key);

  @override
  State<Second> createState() => _SecondState();
}
String treatments="";
DateTime? dateTime;
List users = [];
var my_user;

//Global Text Style
class MyTextStyle {
  static const TextStyle textStyle = TextStyle(
    fontSize: 12,
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

//Global Text Style3
class MyTextStyle3 {
  static const TextStyle textStyle =
      TextStyle(color: Color.fromARGB(255, 35, 134, 166), fontSize: 15);
}

//delete form users with api
Future deleteUser(int id) async {
  final response = await http.delete(
    Uri.parse("https://backend.gohealthination.com/additions/freequote/$id/"),
  );
  //204 olunca da sildi ben de bunu ekledim
  if (response.statusCode == 200 || response.statusCode == 204) {
    print("Connection for delete form users succesful!");
    //var items = json.decode(utf8.decode(response.bodyBytes))["id"];
    //print(response.body);
  } else {
    print('Connection for delete form users not succesful! Response code:');
    print(response.statusCode);
  }
}

class _SecondState extends State<Second> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.fetchUser();
  }

  //display form users with api
  Future fetchUser() async {
    var response = await http.get(Uri.parse(
        "https://backend.gohealthination.com/additions/freequote/?page_size=50"));
    if (response.statusCode == 200) {
      print("Connection for displaying form users succesful.");
      var items = json.decode(utf8.decode(response.bodyBytes))["results"];
      //10 kişiden sonra kimse yok görünüyor!
      //print(items);
      setState(() {
        users = items;
      });
    } else {
      print("Connection for displaying form users is not succesful.");
      setState(() {
        users = [];
      });
    }
    ;
  }

  String warningMessage = "";

  //post form users with api
  Future postQuoteForm() async {
    // This will be sent as form data in the post requst
    if (nameController.text.isNotEmpty &&
        surnameController.text.isNotEmpty &&
        mailController.text.isNotEmpty &&
        phoneController.text.isNotEmpty) {
      final response = await http.post(
        Uri.parse('https://backend.gohealthination.com/additions/freequote/'),
        body: ({
          "first_name": nameController.text,
          "last_name": surnameController.text,
          "email": mailController.text,
          "phoneNumber": phoneController.text,
          "treatment": selectedValue.toString(),
          "subTreatment": key.toString(),
          "isOnlineMeeting": key2.toString(),
        }),
      );

      if (response.statusCode == 200 ||
          response.statusCode == 204 ||
          response.statusCode == 201) {
        print("Connection for post form users succesful!");
        //var items = json.decode(utf8.decode(response.bodyBytes))["id"];
        print("Form Variables: " +
            nameController.text +
            " " +
            surnameController.text +
            " " +
            mailController.text +
            " " +
            phoneController.text +
            " " +
            selectedValue.toString());
      } else {
        print('Connection for post form users not succesful! Response code:');
        print(response.statusCode);
      }
    } else {
      //if fields are empty
      print("Text Fields are empty!");
      warningMessage = "Please fill all the fieldss!";
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
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
          resizeToAvoidBottomInset: true,
          drawer: NavDrawer(),
          //backgroundColor: Colors.blue,
          appBar: AppBar(
            iconTheme: IconThemeData(color: Color.fromARGB(160, 255, 255, 255)),
            title: Padding(
              padding: const EdgeInsets.only(left: 30.0),
              child:
                  SizedBox(width: 150, child: Image.asset("assets/logo.png")),
            ),
          ),
          //whole screen
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
                            "Total Quote Forms",
                            style: TextStyle(
                              color: Color.fromARGB(255, 255, 255, 255),
                              fontWeight: FontWeight.w200,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 100,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                //"Add" Button for Quote Form
                                AddButton(),
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 80.0, bottom: 3),
                  child: ListView.builder(
                    itemCount: users.length,
                    itemBuilder: (context, index) {
                      //date variables
                      var index2 = index + 1;
                      String time = users[index]["created_at"];
                      dateTime = DateTime.parse(time);
                      //treatment variables
                      treatments = users[index]["treatment"].toString();
                      if (treatments == "1") {
                        treatments = "Eye Care";
                      } else if (treatments == "2") {
                        treatments = "Dentistry";
                      } else if (treatments == "3") {
                        treatments = "Plastic Surgery";
                      } else if (treatments == "4") {
                        treatments = "Weight Loss";
                      } else if (treatments == "5") {
                        treatments = "Diabetes";
                        //Dunno what this is?
                      } else if (treatments == "6") {
                        treatments = "Hairtransplant ";
                      } else if (treatments == "7") {
                        treatments = "GeneralFAQ";
                      } else {
                        treatments = "";
                      }
                      //onlie meeting variables
                      String? meeting =
                          users[index]["isOnlineMeeting"].toString();
                      if (meeting == "null" || meeting == "") {
                        meeting = "-";
                      }

                      return Padding(
                        padding: const EdgeInsets.only(
                            top: 10.0, left: 10, right: 10),

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
                                        Color.fromARGB(255, 203, 197, 197),
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
                                                  borderRadius:
                                                      BorderRadius.only(
                                                          topLeft: Radius
                                                              .circular(5),
                                                          bottomLeft:
                                                              Radius.circular(
                                                                  5)),
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
                                                        index2.toString(),
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontSize: 12,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 20,
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Text(
                                                            users[index][
                                                                "first_name"][0],
                                                            style: TextStyle(
                                                              color: Color
                                                                  .fromARGB(
                                                                      184,
                                                                      255,
                                                                      255,
                                                                      255),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontSize: 12,
                                                            ),
                                                          ),
                                                          Text(
                                                            users[index][
                                                                "last_name"][0],
                                                            style: TextStyle(
                                                              color: Color
                                                                  .fromARGB(
                                                                      184,
                                                                      255,
                                                                      255,
                                                                      255),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontSize: 12,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: 20,
                                                      ),
                                                      Text(
                                                        DateFormat.Hm()
                                                            .format(dateTime!),
                                                        style: TextStyle(
                                                          color: Color.fromARGB(
                                                              255,
                                                              255,
                                                              255,
                                                              255),
                                                          fontSize: 11,
                                                        ),
                                                        textAlign:
                                                            TextAlign.center,
                                                      ),
                                                      Text(
                                                        DateFormat.yMd()
                                                            .format(dateTime!),
                                                        style: TextStyle(
                                                            color:
                                                                Color.fromARGB(
                                                                    184,
                                                                    255,
                                                                    255,
                                                                    255),
                                                            fontSize: 12),
                                                        textAlign:
                                                            TextAlign.center,
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
                                            width: 80,
                                            child: Column(
                                              //center horizontally
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              //fixes to the left
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "CUSTOMER:",
                                                  style: MyTextStyle2.textStyle,
                                                ),
                                                Text(
                                                  "EMAIL:",
                                                  style: MyTextStyle2.textStyle,
                                                ),

                                                Text(
                                                  "PHONE:",
                                                  style: MyTextStyle2.textStyle,
                                                ),

                                                //null olunca boş gösterir
                                                Text(
                                                  "TREATMENT:",
                                                  style: MyTextStyle2.textStyle,
                                                ),

                                                //null olduğunda carpı ikonu koy!
                                                Text(
                                                  "MEETING:",
                                                  style: MyTextStyle2.textStyle,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),

                                        //right side's right column
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 15.0),
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
                                                      users[index]
                                                          ["first_name"],
                                                      style:
                                                          MyTextStyle.textStyle,
                                                      softWrap: false,
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                    Text(" "),
                                                    Text(
                                                      users[index]["last_name"],
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
                                                  users[index]["email"],
                                                  style: MyTextStyle.textStyle,
                                                  softWrap: false,
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                                Text(
                                                  users[index]["phoneNumber"],
                                                  style: MyTextStyle.textStyle,
                                                  softWrap: false,
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                                Text(
                                                  treatments,
                                                  style: MyTextStyle.textStyle,
                                                  softWrap: false,
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                                Text(
                                                  meeting,
                                                  style: MyTextStyle.textStyle,
                                                  softWrap: false,
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        //delete and info buttons
                                        Column(
                                          children: [
                                            IconButton(
                                              icon: Icon(Icons.delete),
                                              iconSize: 24.0,
                                              color: Color.fromARGB(
                                                  199, 26, 71, 150),
                                              onPressed: () {
                                                //prints the user id
                                                print(
                                                    "silincek kişinin listviewdeki id'si:");
                                                print(users[index]["id"]);

                                                setState(() {
                                                  deleteUser(
                                                      users[index]["id"]);
                                                  //fetchUser();
                                                  //When a form user deleted, page refreshes
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            const Second(),
                                                      ));
                                                });
                                              },
                                            ),
                                            IconButton(
                                              icon: Icon(Icons.info),
                                              iconSize: 24.0,
                                              color: Color.fromARGB(
                                                  199, 26, 71, 150),
                                              onPressed: () {
                                                //prints the user id
                                                print(
                                                    "info kişinin listviewdeki id'si (global yap!Sonraki sayfaya taşı):");
                                                print(users[index]);

                                                setState(() {
                                                  my_user = users[index];
                                                  
                                                  //When a form user deleted, page refreshes
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            QuoteInfo(),
                                                      ));
                                                });
                                              },
                                            ),
                                          ],
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
          )),
    );
  }
}
