import 'package:flutter/material.dart';
import 'package:healthination_flutterapp/QuoteForm.dart';
import 'PatientProcess.dart';
import 'JobApplications.dart';

class NavDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 230,
      child: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            Container(
              height: 100,
              child: DrawerHeader(
                child: Text(
                  'Pages',
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
                decoration: BoxDecoration(
                  color: Color.fromARGB(137, 26, 51, 150),
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.description,color: Color.fromARGB(255, 10, 55, 117),),
              title: Text('Quote Forms'),
              onTap: () => Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>const Second())),
            ),
            ListTile(
              leading: Icon(Icons.developer_board,color: Color.fromARGB(255, 10, 55, 117),),
              title: Text('Patient Process'),
              onTap: () => Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>const Third())),
            ),
            ListTile(
              leading: Icon(Icons.work_outline,color: Color.fromARGB(255, 10, 55, 117),),
              title: Text('Job Applications'),
              onTap: () => Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>const JopApplications())),
            ),
          ],
        ),
      ),
    );
  }
}



 
