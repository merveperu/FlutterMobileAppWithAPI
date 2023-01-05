import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'sidemenu.dart';
import 'package:google_fonts/google_fonts.dart';
import 'QuoteForm.dart';
import 'package:intl/intl.dart';

//Global Text Style
class MyTextStyle {
  static const TextStyle textStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w200,
    color: Color.fromARGB(206, 15, 39, 124),
  );
}

class MyTextStyle_2 {
  static const TextStyle textStyle = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w200,
    color: Color.fromARGB(255, 27, 39, 82),
  );
}

class QuoteInfo extends StatefulWidget {
  const QuoteInfo({super.key});

  @override
  State<QuoteInfo> createState() => _QuoteInfoState();
}

var my_source;
bool is_visible=false;
var time;
var my_dateTime;

String my_treatment = "";
String my_subtreatment = "";

class _QuoteInfoState extends State<QuoteInfo> {
  void checkSource(){
    if(my_user["source"]==null){
      my_source="Other";
    }
    else{
      my_source=my_user["source"];
    }
  }

  void checkVisible() {
    if(my_user["isOnlineMeeting"]!=null){
      is_visible=true;
    }
    else{
      is_visible=false;
    }
  }

  void Time() {
    setState(() {
      time = my_user["created_at"];
      my_dateTime = DateTime.parse(time);
    });
  }

  void checkTreatment() {
    print(my_user["treatment"]);

    if (my_user["treatment"] == 1) {
      my_treatment = "Eye Care";
    } else if (my_user["treatment"] == 2) {
      my_treatment = "Dentistry";
    } else if (my_user["treatment"] == 3) {
      my_treatment = "Plastic Surgery";
    } else if (my_user["treatment"] == 4) {
      my_treatment = "Weight Loss";
    } else if (my_user["treatment"] == 5) {
      my_treatment = "Diabetes";
      //Dunno what this is?
    } else if (my_user["treatment"] == 6) {
      my_treatment = "Hairtransplant ";
    } else if (my_user["treatment"] == 7) {
      my_treatment = "GeneralFAQ";
    } else {
      my_treatment = " ";
    }
  }

  void checkSubTreatment() {
    print(my_user["subTreatment"]);

    if (my_user["subTreatment"] == 1) {
      my_subtreatment = "LASIK Eye Surgery";
    } else if (my_user["subTreatment"] == 2) {
      my_subtreatment = "Dentistry";
    } else if (my_user["subTreatment"] == 3) {
      my_subtreatment = "Dental Implant";
    } else if (my_user["subTreatment"] == 4) {
      my_subtreatment = "Prosthetic Implant";
    } else if (my_user["subTreatment"] == 5) {
      my_subtreatment = "2";
      //Dunno what this is?
    } else if (my_user["subTreatment"] == 8) {
      my_subtreatment = "GeneralFAQ";
      //Dunno what this is?
    } else {
      my_subtreatment = " ";
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.checkTreatment();
    this.checkSubTreatment();
    this.Time();
    this.checkVisible();
    this.checkSource();
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
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              my_user["first_name"][0] +
                                  my_user["last_name"][0],
                              style: TextStyle(
                                  fontSize: 25,
                                  color: Color.fromARGB(255, 18, 29, 179),
                                  fontWeight: FontWeight.w600),
                            ),
                            Text(" "),
                            Text(
                              my_user["first_name"] +
                                  " " +
                                  my_user["last_name"],
                              style: MyTextStyle.textStyle,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 20.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 10, bottom: 10.0),
                                    child: Text(
                                      "Customer Details",
                                      style: MyTextStyle.textStyle,
                                    ),
                                  ),
                                  Text(
                                    "Full Name: " +
                                        my_user["first_name"] +
                                        " " +
                                        my_user["last_name"],
                                    style: MyTextStyle_2.textStyle,
                                  ),
                                  Text(
                                    "Email: " + my_user["email"],
                                    style: MyTextStyle_2.textStyle,
                                  ),
                                  Text(
                                    "Treatment: " + my_treatment.toString(),
                                    style: MyTextStyle_2.textStyle,
                                  ),
                                  Text(
                                    "Subtreatment: " +
                                        my_subtreatment.toString(),
                                    style: MyTextStyle_2.textStyle,
                                  ),
                                  Text(
                                    "Phone Number: " +
                                        my_user["phoneNumber"].toString(),
                                    style: MyTextStyle_2.textStyle,
                                  ),
                                  Text(
                                    "Source: " + my_source.toString(),
                                    style: MyTextStyle_2.textStyle,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 15.0),
                                    child: Text(
                                      "Quote Form Activity Timeline",
                                      style: MyTextStyle.textStyle,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.fiber_manual_record,
                                          color:
                                              Color.fromARGB(255, 68, 83, 161),
                                          size: 25.0,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(12.0),
                                          child: Column(
                                            children: [
                                              Row(
                                                children: [
                                                  Text(
                                                      "Quote form sent on " +
                                                          DateFormat.Hm()
                                                              .format(
                                                                  my_dateTime),
                                                      style: MyTextStyle_2
                                                          .textStyle),
                                                  Text(
                                                      " " +
                                                          DateFormat.yMd()
                                                              .format(
                                                                  my_dateTime),
                                                      style: MyTextStyle_2
                                                          .textStyle),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Visibility(
                                    visible: is_visible,
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.fiber_manual_record,
                                          color: Color.fromARGB(255, 55, 160, 87),
                                          size: 25.0,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(12.0),
                                          child: Text(
                                            "Patient wants online meeting",
                                            style: MyTextStyle_2.textStyle,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: MaterialButton(
                                  minWidth: 100,
                                  color: Color.fromARGB(255, 195, 35, 35),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Text(
                                    "Delete",
                                    style: TextStyle(color: Colors.white),
                                    textAlign: TextAlign.center,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      deleteUser(my_user["id"]);
                                      //fetchUser();
                                      //When a form user deleted, page refreshes
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const Second(),
                                          ));
                                    });
                                  }),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              )),
        ));
  }
}
