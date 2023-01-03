import 'package:flutter/material.dart';
import 'QuoteForm.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:http/http.dart' as http;

//dropdown variables

//for meting dropdown
String? key2;
//for subtreatment dropdown key and value
int? key;
String? selectedValue_2;

//for treatment dropdown
int? selectedValue;
var selectedValue_3;
Map<int, String> bos = {};
Map<int, String> EyeCare = {
  1: "LASIK Eye Surgery",
};
Map<int, String> Dentistry = {
  3: "Dental Implant",
  4: "Prosthetic Implant",
};
Map<int, String> WeightLoss = {
  5: "Gastric Balloon",
};
Map<int, String> Hairtransplant = {
  5: "2",
};
Map<String?, String> meeting = {
  "": "None",
  "Dr": "Doctor Meeting",
  "CC": "Call Center Meeting",
};

TextEditingController nameController = new TextEditingController();
TextEditingController surnameController = new TextEditingController();
TextEditingController mailController = new TextEditingController();
TextEditingController phoneController = new TextEditingController();

List users = [];
bool isLoading = false;
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
  }
}

//search button for Quote Form Page
class AddButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: MaterialButton(
        minWidth: 90,
        color: Color.fromARGB(255, 26, 72, 150),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        child: Text(
          "Add",
          style: TextStyle(color: Colors.white),
          textAlign: TextAlign.center,
        ),
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return StatefulBuilder(
                  builder: (context, setState) {
                    return AlertDialog(
                      scrollable: true,
                      content: Row(
                        children: [
                          Row(children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 2.0),
                              child: SizedBox(
                                width: 230,
                                child: Column(
                                  //center horizontally
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  //fixes to the left
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TextField(
                                        controller: nameController,
                                        style: const TextStyle(
                                            color: Color.fromARGB(
                                                255, 26, 72, 150),
                                            fontSize: 15),
                                        decoration: InputDecoration(
                                          //filled: true,
                                          //fillColor: Color.fromARGB(91, 252, 252, 252),
                                          prefixIcon: const Icon(Icons.person,
                                              size: 20.0),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                              color: Color.fromARGB(
                                                  255, 35, 134, 166),
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                              color: Color.fromARGB(
                                                  255, 26, 72, 150),
                                              width: 1.3,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),

                                          labelText: 'NAME',
                                          labelStyle: const TextStyle(
                                              color: Color.fromARGB(
                                                  255, 35, 134, 166),
                                              fontSize: 15),
                                        )),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    TextField(
                                        controller: surnameController,
                                        style: const TextStyle(
                                            color: Color.fromARGB(
                                                255, 26, 72, 150),
                                            fontSize: 15),
                                        decoration: InputDecoration(
                                          //filled: true,
                                          //fillColor: Color.fromARGB(91, 252, 252, 252),
                                          prefixIcon: const Icon(Icons.person,
                                              size: 20.0),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                              color: Color.fromARGB(
                                                  255, 35, 134, 166),
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                              color: Color.fromARGB(
                                                  255, 26, 72, 150),
                                              width: 1.3,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),

                                          labelText: 'SURNAME',
                                          labelStyle: const TextStyle(
                                              color: Color.fromARGB(
                                                  255, 35, 134, 166),
                                              fontSize: 15),
                                        )),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    TextField(
                                        controller: mailController,
                                        style: const TextStyle(
                                            color: Color.fromARGB(
                                                255, 26, 72, 150),
                                            fontSize: 15),
                                        decoration: InputDecoration(
                                          //filled: true,
                                          //fillColor: Color.fromARGB(91, 252, 252, 252),
                                          prefixIcon: const Icon(Icons.mail,
                                              size: 20.0),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                              color: Color.fromARGB(
                                                  255, 35, 134, 166),
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                              color: Color.fromARGB(
                                                  255, 26, 72, 150),
                                              width: 1.3,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),

                                          labelText: 'E-MAIL',
                                          labelStyle: const TextStyle(
                                              color: Color.fromARGB(
                                                  255, 35, 134, 166),
                                              fontSize: 15),
                                        )),
                                    SizedBox(
                                      height: 10,
                                    ),

                                    Center(
                                      child: SizedBox(
                                        width: 700,
                                        height: 55,
                                        child: DecoratedBox(
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Color.fromARGB(
                                                    255, 35, 134, 166),
                                                width: 1.2),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: DropdownButtonFormField(
                                              decoration: InputDecoration(
                                                enabledBorder: InputBorder.none,
                                                focusedBorder: InputBorder.none,
                                                prefixIcon:
                                                    Icon(Icons.local_hospital),
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
                                                  bos = EyeCare;
                                                } else if (selectedValue == 2) {
                                                  bos = Dentistry;
                                                } else if (selectedValue == 3) {
                                                  bos = WeightLoss;
                                                } else {
                                                  bos = Hairtransplant;
                                                }

                                                setState(() {
                                                  selectedValue_2 = null;
                                                  selectedValue =
                                                      newvalue as int;
                                                  print("Selected: " +
                                                      newvalue.toString());
                                                });
                                              },
                                              hint: Text(
                                                "Select Treatment",
                                                style: MyTextStyle3.textStyle,
                                              ),
                                              style: TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 35, 134, 166),
                                                  fontSize: 15),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    //Subtreatment

                                    Center(
                                      child: SizedBox(
                                        width: 700,
                                        height: 55,
                                        child: DecoratedBox(
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Color.fromARGB(
                                                    255, 35, 134, 166),
                                                width: 1.2),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Padding(
                                              padding:
                                                  const EdgeInsets.all(5.0),
                                              child: DropdownButtonFormField(
                                                decoration: InputDecoration(
                                                  enabledBorder:
                                                      InputBorder.none,
                                                  focusedBorder:
                                                      InputBorder.none,
                                                  prefixIcon: Icon(
                                                      Icons.health_and_safety),
                                                ),
                                                // Initial Value
                                                value: selectedValue_2,

                                                // Down Arrow Icon
                                                icon: const Icon(
                                                    Icons.keyboard_arrow_down),
                                                // Array list of items
                                                items: [
                                                  for (MapEntry<int, String> e
                                                      in bos.entries)
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

                                                    key = bos.keys.firstWhere(
                                                        (k) =>
                                                            bos[k] ==
                                                            selectedValue_2);
                                                    print(
                                                        "Selected Subtreatment: " +
                                                            key.toString() +
                                                            " " +
                                                            selectedValue_2
                                                                .toString());

                                                    // bos.keys.forEach((key) {
                                                    //   print(key);
                                                    // });
                                                  });
                                                },
                                                hint: Text(
                                                  "Select SubTreatment",
                                                  style: MyTextStyle3.textStyle,
                                                ),
                                                style: TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 35, 134, 166),
                                                    fontSize: 15),
                                              )),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    //Meeting dropdown button
                                    Center(
                                      child: SizedBox(
                                        width: 700,
                                        height: 55,
                                        child: DecoratedBox(
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Color.fromARGB(
                                                    255, 35, 134, 166),
                                                width: 1.2),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Padding(
                                              padding:
                                                  const EdgeInsets.all(5.0),
                                              child: DropdownButtonFormField(
                                                decoration: InputDecoration(
                                                  enabledBorder:
                                                      InputBorder.none,
                                                  focusedBorder:
                                                      InputBorder.none,
                                                  prefixIcon:
                                                      Icon(Icons.groups),
                                                ),
                                                // Initial Value
                                                value: selectedValue_3,

                                                // Down Arrow Icon
                                                icon: const Icon(
                                                    Icons.keyboard_arrow_down),
                                                // Array list of items
                                                items: [
                                                  for (MapEntry<String?,
                                                          String> e
                                                      in meeting.entries)
                                                    DropdownMenuItem(
                                                      value: e.value,
                                                      child: Text(e.value),
                                                    ),
                                                ],
                                                // After selecting the desired option,it will
                                                // change button value to selected value
                                                onChanged: (newValue) {
                                                  setState(() {
                                                    selectedValue_3 =
                                                        newValue as String;
                                                    print(selectedValue_3);
                                                    //key2 is the key of the meeting
                                                    //When NONE selected it's value is ""

                                                    key2 = meeting.keys
                                                        .firstWhere((k) =>
                                                            meeting[k] ==
                                                            selectedValue_3);
                                                    print(
                                                        "Selected Subtreatment key : " +
                                                            key2.toString() +
                                                            " " +
                                                            selectedValue_3
                                                                .toString());

                                                    // bos.keys.forEach((key) {
                                                    //   print(key);
                                                    // });
                                                  });
                                                },
                                                hint: Text(
                                                  "Select Meeting",
                                                  style: MyTextStyle3.textStyle,
                                                ),
                                                style: TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 35, 134, 166),
                                                    fontSize: 15),
                                              )),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    IntlPhoneField(
                                      controller: phoneController,
                                      style: TextStyle(
                                          color:
                                              Color.fromARGB(255, 26, 72, 150),
                                          fontSize: 15),
                                      decoration: InputDecoration(
                                        labelText: 'Phone Number',
                                        labelStyle: const TextStyle(
                                            color: Color.fromARGB(
                                                255, 35, 134, 166),
                                            fontSize: 15),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                            color: Color.fromARGB(
                                                255, 35, 134, 166),
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                            color: Color.fromARGB(
                                                255, 26, 72, 150),
                                            width: 1.3,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      ),
                                      initialCountryCode: 'TR',
                                      onChanged: (phone) {
                                        setState(() {
                                          phone = phone;
                                          //print(phone.completeNumber);
                                        });
                                      },
                                    ),
                                    Row(
                                      children: [
                                        Center(
                                          child: MaterialButton(
                                              minWidth: 100,
                                              color: Color.fromARGB(
                                                  255, 26, 72, 150),
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(5)),
                                              child: Text(
                                                "Add",
                                                style: TextStyle(
                                                    color: Colors.white),
                                                textAlign: TextAlign.center,
                                              ),
                                              onPressed: () {
                                                setState(() {
                                                  postQuoteForm();
                                                  if (nameController.text.isNotEmpty &&
                                                      surnameController
                                                          .text.isNotEmpty &&
                                                      phoneController
                                                          .text.isNotEmpty &&
                                                      mailController
                                                          .text.isNotEmpty &&
                                                      key != null &&
                                                      selectedValue != null) {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              const Second(),
                                                        ));
                                                  }
                                                });
                                              }),
                                        ),
                                        Spacer(),
                                        Center(
                                          child: MaterialButton(
                                              minWidth: 100,
                                              color: Color.fromARGB(
                                                  255, 195, 35, 35),
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(5)),
                                              child: Text(
                                                "Cancel",
                                                style: TextStyle(
                                                    color: Colors.white),
                                                textAlign: TextAlign.center,
                                              ),
                                              onPressed: () {
                                                setState(() {
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
                              ),
                            ),
                          ]),
                        ],
                      ),
                    );
                  },
                );
              });
        },
      ),
    );
  }
}
