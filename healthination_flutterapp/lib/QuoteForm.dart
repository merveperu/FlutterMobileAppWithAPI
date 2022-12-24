import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'sidemenu.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class Second extends StatefulWidget {
  const Second({Key? key}) : super(key: key);

  @override
  State<Second> createState() => _SecondState();
}

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

class _SecondState extends State<Second> {
  //dropdown button value
  int value = 1;
  TextEditingController nameController = new TextEditingController();
  TextEditingController surnameController = new TextEditingController();
  TextEditingController mailController = new TextEditingController();
  TextEditingController phoneController = new TextEditingController();

  List users = [];
  bool isLoading = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.fetchUser();
  }

  //display form users with api
  Future fetchUser() async {
    var response = await http.get(
        Uri.parse("https://backend.gohealthination.com/additions/freequote/"));
    if (response.statusCode == 200) {
      print("Connection for displaying form users succesful.");
      var items = json.decode(utf8.decode(response.bodyBytes))["results"];
      //10 kişiden sonra kimse yok görünüyor!
      print(items);
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

  //delete form users with api
  Future deleteUser(int id) async {
    final response = await http.delete(
      Uri.parse("https://backend.gohealthination.com/additions/freequote/$id/"),
    );
    //204 olunca da sildi ben de bunu ekledim
    if (response.statusCode == 200 || response.statusCode == 204) {
      print("Connection for delete form users succesful!");
      //var items = json.decode(utf8.decode(response.bodyBytes))["id"];
      print(response.body);
    } else {
      print('Connection for delete form users not succesful! Response code:');
      print(response.statusCode);
    }
  }

  //post form users with api
  Future postQuoteForm() async {
    // This will be sent as form data in the post requst
    if (nameController.text.isNotEmpty && surnameController.text.isNotEmpty) {
      final response = await http.post(
        Uri.parse('https://backend.gohealthination.com/additions/freequote/'),
        body: ({
          "first_name": nameController.text,
          "last_name": surnameController.text,
          "email": mailController.text,
          "phoneNumber": phoneController.text,
          "treatment": value.toString(),
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 204 || response.statusCode==201) {
        
        print("Connection for post form users succesful!");
        //var items = json.decode(utf8.decode(response.bodyBytes))["id"];
        print("Form Variables: "+nameController.text+" "+surnameController.text+" "+mailController.text+" "+phoneController.text+" "+value.toString());
      } else {
        print('Connection for post form users not succesful! Response code:');
        print(response.statusCode);
      }
    }else{
      print("ne oluyor?");
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
          color: Color.fromARGB(137, 26, 51, 150), //<-- SEE HERE
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
                            "Total Quote Forms",
                            style: TextStyle(
                              color: Color.fromARGB(255, 255, 255, 255),
                              fontWeight: FontWeight.w200,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                      //Create Button for Quote Form
                      SizedBox(
                        width: 100,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                MaterialButton(
                                  minWidth: 90,
                                  color: Color.fromARGB(255, 26, 72, 150),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Text(
                                    "Add",
                                    style: TextStyle(color: Colors.white),
                                    textAlign: TextAlign.center,
                                  ),
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            scrollable: true,
                                            content: Row(
                                              children: [
                                                Row(children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 2.0),
                                                    child: SizedBox(
                                                      width: 230,
                                                      child: Column(
                                                        //center horizontally
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        //fixes to the left
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          TextField(
                                                              controller:
                                                                  nameController,
                                                              style: const TextStyle(
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          26,
                                                                          72,
                                                                          150),
                                                                  fontSize: 15),
                                                              decoration:
                                                                  InputDecoration(
                                                                //filled: true,
                                                                //fillColor: Color.fromARGB(91, 252, 252, 252),
                                                                prefixIcon:
                                                                    const Icon(
                                                                        Icons
                                                                            .person,
                                                                        size:
                                                                            20.0),
                                                                enabledBorder:
                                                                    OutlineInputBorder(
                                                                  borderSide:
                                                                      const BorderSide(
                                                                    color: Color
                                                                        .fromARGB(
                                                                            255,
                                                                            35,
                                                                            134,
                                                                            166),
                                                                  ),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10),
                                                                ),
                                                                focusedBorder:
                                                                    OutlineInputBorder(
                                                                  borderSide:
                                                                      const BorderSide(
                                                                    color: Color
                                                                        .fromARGB(
                                                                            255,
                                                                            26,
                                                                            72,
                                                                            150),
                                                                    width: 1.3,
                                                                  ),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10),
                                                                ),

                                                                labelText:
                                                                    'NAME',
                                                                labelStyle: const TextStyle(
                                                                    color: Color
                                                                        .fromARGB(
                                                                            255,
                                                                            35,
                                                                            134,
                                                                            166),
                                                                    fontSize:
                                                                        15),
                                                              )),
                                                          SizedBox(
                                                            height: 10,
                                                          ),
                                                          TextField(
                                                              controller:
                                                                  surnameController,
                                                              style: const TextStyle(
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          26,
                                                                          72,
                                                                          150),
                                                                  fontSize: 15),
                                                              decoration:
                                                                  InputDecoration(
                                                                //filled: true,
                                                                //fillColor: Color.fromARGB(91, 252, 252, 252),
                                                                prefixIcon:
                                                                    const Icon(
                                                                        Icons
                                                                            .person,
                                                                        size:
                                                                            20.0),
                                                                enabledBorder:
                                                                    OutlineInputBorder(
                                                                  borderSide:
                                                                      const BorderSide(
                                                                    color: Color
                                                                        .fromARGB(
                                                                            255,
                                                                            35,
                                                                            134,
                                                                            166),
                                                                  ),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10),
                                                                ),
                                                                focusedBorder:
                                                                    OutlineInputBorder(
                                                                  borderSide:
                                                                      const BorderSide(
                                                                    color: Color
                                                                        .fromARGB(
                                                                            255,
                                                                            26,
                                                                            72,
                                                                            150),
                                                                    width: 1.3,
                                                                  ),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10),
                                                                ),

                                                                labelText:
                                                                    'SURNAME',
                                                                labelStyle: const TextStyle(
                                                                    color: Color
                                                                        .fromARGB(
                                                                            255,
                                                                            35,
                                                                            134,
                                                                            166),
                                                                    fontSize:
                                                                        15),
                                                              )),
                                                          SizedBox(
                                                            height: 10,
                                                          ),
                                                          TextField(
                                                              controller:
                                                                  mailController,
                                                              style: const TextStyle(
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          26,
                                                                          72,
                                                                          150),
                                                                  fontSize: 15),
                                                              decoration:
                                                                  InputDecoration(
                                                                //filled: true,
                                                                //fillColor: Color.fromARGB(91, 252, 252, 252),
                                                                prefixIcon:
                                                                    const Icon(
                                                                        Icons
                                                                            .mail,
                                                                        size:
                                                                            20.0),
                                                                enabledBorder:
                                                                    OutlineInputBorder(
                                                                  borderSide:
                                                                      const BorderSide(
                                                                    color: Color
                                                                        .fromARGB(
                                                                            255,
                                                                            35,
                                                                            134,
                                                                            166),
                                                                  ),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10),
                                                                ),
                                                                focusedBorder:
                                                                    OutlineInputBorder(
                                                                  borderSide:
                                                                      const BorderSide(
                                                                    color: Color
                                                                        .fromARGB(
                                                                            255,
                                                                            26,
                                                                            72,
                                                                            150),
                                                                    width: 1.3,
                                                                  ),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10),
                                                                ),

                                                                labelText:
                                                                    'E-MAIL',
                                                                labelStyle: const TextStyle(
                                                                    color: Color
                                                                        .fromARGB(
                                                                            255,
                                                                            35,
                                                                            134,
                                                                            166),
                                                                    fontSize:
                                                                        15),
                                                              )),
                                                          SizedBox(
                                                            height: 10,
                                                          ),

                                                          //I had to do this because onChanged was not working. (Took 3 hours to find!)
                                                          StatefulBuilder(
                                                              builder: (context,
                                                                  setState) {
                                                            return Center(
                                                              child: SizedBox(
                                                                width: 700,
                                                                height: 55,
                                                                child:
                                                                    DecoratedBox(
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    border: Border.all(
                                                                        color: Color.fromARGB(
                                                                            255,
                                                                            35,
                                                                            134,
                                                                            166),
                                                                        width:
                                                                            1.2),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10),
                                                                  ),
                                                                  child:
                                                                      Padding(
                                                                    padding:
                                                                        const EdgeInsets.all(
                                                                            5.0),
                                                                    child:
                                                                        DropdownButtonFormField(
                                                                      decoration:
                                                                          InputDecoration(
                                                                        enabledBorder:
                                                                            InputBorder.none,
                                                                        focusedBorder:
                                                                            InputBorder.none,
                                                                        prefixIcon:
                                                                            Icon(Icons.local_hospital),
                                                                      ),
                                                                      value:
                                                                          value,
                                                                      items: [
                                                                        DropdownMenuItem(
                                                                          child:
                                                                              Text("Eye Care"),
                                                                          value:
                                                                              1,
                                                                        ),
                                                                        DropdownMenuItem(
                                                                          child:
                                                                              Text("Dentistry"),
                                                                          value:
                                                                              2,
                                                                        ),
                                                                        DropdownMenuItem(
                                                                          child:
                                                                              Text("Weight Loss"),
                                                                          value:
                                                                              3,
                                                                        ),
                                                                        DropdownMenuItem(
                                                                          child:
                                                                              Text("Hairtransplant"),
                                                                          value:
                                                                              4,
                                                                        ),
                                                                      ],
                                                                      onChanged:
                                                                          (newvalue) {
                                                                        value = newvalue
                                                                            as int;
                                                                        setState(
                                                                            () {
                                                                          value =
                                                                              newvalue as int;
                                                                          print("Selected: " +
                                                                              newvalue.toString());
                                                                        });
                                                                      },
                                                                      style: TextStyle(
                                                                          color: Color.fromARGB(
                                                                              255,
                                                                              35,
                                                                              134,
                                                                              166),
                                                                          fontSize:
                                                                              15),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            );
                                                          }),
                                                          SizedBox(
                                                            height: 10,
                                                          ),
                                                          IntlPhoneField(
                                                            controller:
                                                                phoneController,
                                                            style: TextStyle(
                                                                color: Color
                                                                    .fromARGB(
                                                                        255,
                                                                        26,
                                                                        72,
                                                                        150),
                                                                fontSize: 15),
                                                            decoration:
                                                                InputDecoration(
                                                              labelText:
                                                                  'Phone Number',
                                                              labelStyle: const TextStyle(
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          35,
                                                                          134,
                                                                          166),
                                                                  fontSize: 15),
                                                              enabledBorder:
                                                                  OutlineInputBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10),
                                                                borderSide:
                                                                    BorderSide(
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          35,
                                                                          134,
                                                                          166),
                                                                ),
                                                              ),
                                                              focusedBorder:
                                                                  OutlineInputBorder(
                                                                borderSide:
                                                                    const BorderSide(
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          26,
                                                                          72,
                                                                          150),
                                                                  width: 1.3,
                                                                ),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10),
                                                              ),
                                                            ),
                                                            initialCountryCode:
                                                                'TR',
                                                            onChanged: (phone) {
                                                              setState(() {
                                                                phone=phone; 
                                                                //print(phone.completeNumber);
                                                              });
                                                              
                                                            },
                                                          ),
                                                          Center(
                                                            child:
                                                                MaterialButton(
                                                                    minWidth:
                                                                        270,
                                                                    color: Color
                                                                        .fromARGB(
                                                                            255,
                                                                            26,
                                                                            72,
                                                                            150),
                                                                    shape: RoundedRectangleBorder(
                                                                        borderRadius:
                                                                            BorderRadius.circular(
                                                                                5)),
                                                                    child: Text(
                                                                      "Add",
                                                                      style: TextStyle(
                                                                          color:
                                                                              Colors.white),
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                    ),
                                                                    onPressed:
                                                                        () {
                                                                      setState(
                                                                          () {
                                                                        postQuoteForm();
                                                                        Navigator.push(
                                                                            context,
                                                                            MaterialPageRoute(
                                                                              builder: (context) => const Second(),
                                                                            ));
                                                                      });
                                                                    }),
                                                          ),
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
                                )
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
                      DateTime dateTime = DateTime.parse(time);
                      //treatment variables
                      String treatments = users[index]["treatment"].toString();
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
                        treatments = " ";
                      } else if (treatments == "7") {
                        treatments = "GeneralFAQ";
                      } else {
                        treatments = "Hairtransplant";
                      }
                      //onlie meeting variables
                      String? meeting =
                          users[index]["isOnlineMeeting"].toString();
                      if (meeting == "null") {
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
                                                            .format(dateTime),
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
                                                            .format(dateTime),
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
                                        //delete button
                                        IconButton(
                                          icon: Icon(Icons.delete),
                                          iconSize: 24.0,
                                          color:
                                              Color.fromARGB(199, 26, 71, 150),
                                          onPressed: () {
                                            //prints the user id
                                            print(
                                                "silincek kişinin listviewdeki id'si:");
                                            print(users[index]["id"]);

                                            setState(() {
                                              deleteUser(users[index]["id"]);
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
