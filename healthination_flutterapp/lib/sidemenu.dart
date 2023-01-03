import 'package:flutter/material.dart';
import 'package:healthination_flutterapp/Chat.dart';
import 'package:healthination_flutterapp/HomePage.dart';
import 'package:healthination_flutterapp/QuoteForm.dart';
import 'PatientProcess.dart';
import 'JobApplications.dart';
import 'main.dart';
import 'package:http/http.dart' as http;

//menu header text style
class MyTextStyle {
  static const TextStyle textStyle = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w300,
    color: Color.fromARGB(255, 10, 55, 117),
  );
}

//Menu profile texts
class MyTextStyle2 {
  static const TextStyle textStyle = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w300,
    color: Color.fromARGB(255, 10, 55, 117),
  );
}




class NavDrawer extends StatefulWidget {
  @override
  State<NavDrawer> createState() => _NavDrawerState();
}

class _NavDrawerState extends State<NavDrawer> {
  
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 230,
      child: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            Container(
              height: 170,
              child: DrawerHeader(
                child: Column(
                  children: [
                    ClipRRect(
                      child: Image.network(
                        "$myPhoto",
                        width: 70,
                        height: 70,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(height: 10,),
                    Text(myUserName,style: MyTextStyle2.textStyle,),
                  ],
                ),
                decoration: BoxDecoration(
                  color: Color.fromARGB(137, 26, 51, 150),
                ),
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.home,
                color: Color.fromARGB(255, 10, 55, 117),
              ),
              title: Text(
                'Home',
                style: MyTextStyle.textStyle,
              ),
              onTap: () => Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const HomePage())),
            ),
            ListTile(
              leading: Icon(
                Icons.description,
                color: Color.fromARGB(255, 10, 55, 117),
              ),
              title: Text('Quote Forms', style: MyTextStyle.textStyle),
              onTap: () => Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const Second())),
            ),
            ListTile(
              leading: Icon(
                Icons.work,
                color: Color.fromARGB(255, 10, 55, 117),
              ),
              title: Text('Job Applications', style: MyTextStyle.textStyle),
              onTap: () => Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                      builder: (context) => const JopApplications())),
            ),
            ListTile(
              leading: Icon(
                Icons.chat,
                color: Color.fromARGB(255, 10, 55, 117),
              ),
              title: Text('Chat', style: MyTextStyle.textStyle),
              onTap: () => Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const ChatPage())),
            ),
            ListTile(
              leading: Icon(
                Icons.developer_board,
                color: Color.fromARGB(255, 10, 55, 117),
              ),
              title: Text('Patient Process', style: MyTextStyle.textStyle),
              onTap: () => Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const Third())),
            ),
          ],
        ),
      ),
    );
  }
}
