import 'package:flutter/material.dart';
import 'package:leczone/Thirdscreen.dart';
import 'google.dart';
import 'top_bar.dart';
class Student1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
          children: <Widget>[
            TopBar(),
            SizedBox(height: 160,),
            RaisedButton(
              elevation: 20.0,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
              child: Container(
                width: 350,
                height: 60,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(25.0)),
                child: Row(
                  children: <Widget>[
                    CircleAvatar(
                      backgroundImage:AssetImage("images/google.jpg") ,
                    ),
                    SizedBox(width: 60.0,),
                    Text("Login with Google ",
                    style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 20.0),
                    )
                  ],
                ),
              ),
             onPressed: () {
    signInWithGoogle().whenComplete(() {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) {
            return Third();
          },
        ),
      );
    });
  },
            )
          ],
      ),
      
    );
  }
}