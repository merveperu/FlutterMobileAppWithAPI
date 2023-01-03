import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'sidemenu.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

//Global Text Style3
class MyTextStyle3 {
  static const TextStyle textStyle =
      TextStyle(color: Color.fromARGB(255, 35, 134, 166), fontSize: 15);
}

String? selectedValue_2;
int? selectedValue;
Map<int, String> bos = {};
Map<int, String> denemeMap = {
  1: "one",
  2: "two",
};
Map<int, String> denemeMap2 = {
  3: "Three",
  4: "four",
};
Map<int, String> denemeMap3 = {
  5: "Five",
  6: "six",
};

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Home Page",
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
        body: Padding(
          padding: const EdgeInsets.all(50.0),
          child: Container(
            width: 500,
            height: 500,
            decoration: BoxDecoration(
                gradient: new LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color.fromARGB(105, 51, 28, 142),
                Color.fromARGB(139, 35, 171, 96)
              ],
            )),
            child: Column(
              children: [
                //üstteki buton
                DropdownButtonFormField(
                  decoration: InputDecoration(
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    prefixIcon: Icon(Icons.local_hospital),
                  ),
                  value: selectedValue,
                  items: [
                    DropdownMenuItem(
                      child: Text("Eye Care"),
                      value: 1,
                    ),
                    DropdownMenuItem(
                      child: Text("Dentistry"),
                      value: 2,
                    ),
                    DropdownMenuItem(
                      child: Text("Weight Loss"),
                      value: 3,
                    ),
                    DropdownMenuItem(
                      child: Text("Hairtransplant"),
                      value: 4,
                    ),
                  ],
                  onChanged: (newvalue) {
                    selectedValue = newvalue as int;
                    if (selectedValue == 1) {
                      bos = denemeMap;
                    } else if (selectedValue == 2) {
                      bos = denemeMap2;
                    } else if (selectedValue == 3) {
                      bos = denemeMap3;
                    } else {
                      bos = {};
                    }

                    setState(() {
                      selectedValue_2 = null;
                      selectedValue = newvalue as int;
                      print("Selected: " + newvalue.toString());
                    });
                  },
                  hint: Text(
                    "Select Treatment",
                    style: MyTextStyle3.textStyle,
                  ),
                  style: TextStyle(
                      color: Color.fromARGB(255, 35, 134, 166), fontSize: 15),
                ),

                //subtreatment
                //alttaki
                DropdownButtonFormField(
                  decoration: InputDecoration(
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    prefixIcon: Icon(Icons.health_and_safety),
                  ),
                  // Initial Value
                  value: selectedValue_2,

                  // Down Arrow Icon
                  icon: const Icon(Icons.keyboard_arrow_down),
                  // Array list of items
                  items: [
                    for (MapEntry<int, String> e in bos.entries)
                      DropdownMenuItem(
                        value: e.value,
                        child: Text(e.value),
                      ),
                  ],
                  // After selecting the desired option,it will
                  // change button value to selected value
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedValue_2 = newValue!;

                      var key =
                          bos.keys.firstWhere((k) => bos[k] == selectedValue_2);
                      print("Selected Subtreatment: " +
                          key.toString() +
                          " " +
                          selectedValue_2.toString());
                    });
                  },
                  hint: Text(
                    "Select SubTreatment",
                    style: MyTextStyle3.textStyle,
                  ),
                  style: TextStyle(
                      color: Color.fromARGB(255, 35, 134, 166), fontSize: 15),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
