import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:leczone/global.dart';
import 'package:uuid/uuid.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class Math extends StatefulWidget {
  @override
  _MathState createState() => _MathState();
}

class _MathState extends State<Math> {
  
  @override
  void initState() {
    super.initState();
     DatabaseReference db = FirebaseDatabase.instance.reference().child("Subjects").child("Math");
    db.once().then((DataSnapshot snapshot){
      values=snapshot.value;
      values.forEach((key,value){
        print(value);
      }
      );
  
    });
  }
  @override
  Widget build(BuildContext context) {
   
    return Scaffold();
    
  }
  

}