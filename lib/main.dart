import 'package:flutter/material.dart';
import 'package:leczone/secondscreen.dart';
import 'package:leczone/student.dart';
import 'package:google_fonts/google_fonts.dart';
import 'Colors.dart';
import 'top_bar.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Curved Path',
      debugShowCheckedModeBanner: false,
      theme: appTheme,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
             TopBar(),
             SizedBox(height: 150,),
             RaisedButton(
               color: Colors.blue,
               elevation: 20.0,
               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14.0)),
               child: Container(
                 width: 250,
                 height: 60,
                 child: Center(
                   child: Text("Student",
                   style: GoogleFonts.pacifico(
                                color: Colors.white,
                                fontSize: 25.0,
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.w500,
                              )
                   ),
                 ),
                 decoration: BoxDecoration(
                   borderRadius: BorderRadius.circular(14.0)
                 ),
               ),
               onPressed: (){
                 Navigator.push(context, MaterialPageRoute(builder: (context)=>Student()));

               },
             ),
             SizedBox(height: 50,),
              RaisedButton(
               color: Colors.blue,
               elevation: 20.0,
               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14.0)),
               child: Container(
                 width: 250,
                 height: 60,
                 child: Center(
                   child: Text("Faculty",
                   style: GoogleFonts.pacifico(
                                color: Colors.white,
                                fontSize: 25.0,
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.w500,
                              )
                   ),
                 ),
                 decoration: BoxDecoration(
                   borderRadius: BorderRadius.circular(14.0)
                 ),
               ),
               onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>Student1()));
               },
             )
        ],
      ),
    );
  }
}