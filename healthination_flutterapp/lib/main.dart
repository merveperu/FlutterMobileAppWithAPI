import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healthination_flutterapp/AddButton.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'QuoteForm.dart';
import 'HomePage.dart';

void main() {
  runApp(const MyApp());
}

//id of the current user
String myPhoto = "";
String myUserName = "";
int myId = 0;
String myFirstName = "";
String myLastName = "";

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    const appTitle = 'Healthination';
    return MaterialApp(
      theme: ThemeData(
        textTheme: GoogleFonts.latoTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      title: appTitle,
      home: const Scaffold(
        appBar: null,
        resizeToAvoidBottomInset: false,
        //body: const MyCustomForm(),
        body: MyCustomForm(),
      ),
    );
  }
}

class MyCustomForm extends StatefulWidget {
  const MyCustomForm({Key? key}) : super(key: key);

  @override
  State<MyCustomForm> createState() => _MyCustomFormState();
}

//global text style for icons of healthination
class MyTextStyle {
  static const TextStyle textStyle = TextStyle(
    fontSize: 25,
    fontWeight: FontWeight.w500,
    color: Color.fromARGB(255, 26, 72, 150),
  );
}

class _MyCustomFormState extends State<MyCustomForm> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.signIn();
  }

  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  //Login with API
  Future<void> signIn() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (passwordController.text.isNotEmpty && emailController.text.isNotEmpty) {
      var response = await http.post(
          Uri.parse(
              "https://backend.gohealthination.com/users/dj-rest-auth/login/"),
          body: ({
            "email": emailController.text,
            "password": passwordController.text,
          }));

      if (response.statusCode == 200) {
        Map<String, dynamic> output = json.decode(response.body);
        final body = jsonDecode(utf8.decode(response.bodyBytes));

        print(response.body);
        print("Token: " + body["key"].toString());
        print("Connection for login succesful");
        print(body["user"]["username"]);
        print(body["user"]["id"]);
        print(body["user"]["first_name"]);
        print(body["user"]["last_name"]);

        setState(() {
          myUserName = body["user"]["username"];
          myPhoto = body["user"]["userPhoto"].toString();
          myId = body["user"]["id"];
          myFirstName = body["user"]["first_name"];
          myLastName = body["user"]["last_name"];
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const HomePage(),
              ));
        });
      } else {
        //If mail or password is wrong print message
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            //behavior: SnackBarBehavior.floating,
            //margin: EdgeInsets.only(bottom: 10.0),
            backgroundColor: Colors.red,
            content:
                Text("Wrong password or email!", textAlign: TextAlign.center)));
        print("invalid crediantials");
        print(response.statusCode);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      //to fill the entire screen with background
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,

      //background image
      decoration: const BoxDecoration(
        //color: Color.fromARGB(187, 108, 157, 197),
        image: DecorationImage(
          image: AssetImage("assets/bg8.png"),
          fit: BoxFit.fill,
        ),
      ),

      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 100.0),
          child: Column(children: [
            const Text(
              "Welcome Back!",
              style: MyTextStyle.textStyle,
            ),
            const Text(
              "Login to your account",
              style: TextStyle(
                  fontSize: 12, color: Color.fromARGB(255, 26, 72, 150)),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30, top: 70, right: 30),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: 400,
                  height: 50,
                  child: TextField(
                      controller: emailController,
                      style: const TextStyle(
                          color: Color.fromARGB(255, 26, 72, 150),
                          fontSize: 12),
                      decoration: InputDecoration(
                        //filled: true,
                        //fillColor: Color.fromARGB(91, 252, 252, 252),
                        prefixIcon: const Icon(Icons.person, size: 20.0),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Color.fromARGB(255, 35, 134, 166),
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Color.fromARGB(255, 26, 72, 150),
                            width: 1.3,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),

                        labelText: 'Email',
                        labelStyle: const TextStyle(
                            color: Color.fromARGB(255, 35, 134, 166),
                            fontSize: 12),
                      )),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30, right: 30),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: 400,
                  height: 50,
                  child: TextFormField(
                      controller: passwordController,
                      style: const TextStyle(
                          color: Color.fromARGB(255, 26, 72, 150),
                          fontSize: 12,
                          fontWeight: FontWeight.w400),
                      obscureText: true,
                      decoration: InputDecoration(
                        //filled with color textform
                        //filled: true,
                        //fillColor: Color.fromARGB(91, 252, 252, 252),
                        prefixIcon: const Icon(Icons.lock, size: 20.0),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                              color: Color.fromARGB(255, 35, 134, 166)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Color.fromARGB(255, 26, 72, 150),
                            width: 1.3,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),

                        labelText: 'Password',
                        labelStyle: const TextStyle(
                            color: Color.fromARGB(255, 35, 134, 166),
                            fontSize: 12),
                      )),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 190.0),
              child: Text(
                "Forgot Password?",
                style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                    color: Color.fromARGB(255, 26, 72, 150)),
              ),
            ),

            const SizedBox(
              height: 80,
            ),

            //Sign In Button
            Container(
              height: 40,
              width: 280,
              child: MaterialButton(
                onPressed: () {
                  if (emailController.text.isNotEmpty &&
                      passwordController.text.isNotEmpty) {
                    signIn();
                  } else {
                    //when textfields are empty
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        //behavior: SnackBarBehavior.floating,
                        //margin: EdgeInsets.only(bottom: 10.0),
                        backgroundColor: Colors.red,
                        content: Text(
                          "Please fill all the area!",
                          textAlign: TextAlign.center,
                        )));
                  }
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(80.0)),
                padding: const EdgeInsets.all(0.0),
                child: Ink(
                  decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          Color.fromARGB(255, 29, 38, 99),
                          Color(0xff64B6FF)
                        ],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      borderRadius: BorderRadius.circular(30.0)),
                  child: Container(
                    constraints:
                        const BoxConstraints(maxWidth: 300.0, minHeight: 50.0),
                    alignment: Alignment.center,
                    child: const Text(
                      "Sign In",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(
              height: 8,
            ),

            Row(
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 100.0),
                  child: Text(
                    "Don't have an account?",
                    style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        color: Color.fromARGB(255, 26, 72, 150)),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 8),
                  child: Text(
                    "Sign Up",
                    style: TextStyle(
                        decoration: TextDecoration.underline,
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: Color.fromARGB(255, 26, 72, 150)),
                  ),
                ),
              ],
            ),
          ]),
        ),
      ),
    );
  }
}
