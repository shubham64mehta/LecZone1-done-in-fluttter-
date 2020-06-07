import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:leczone/global.dart';

class Picker extends StatefulWidget {
  @override
  _PickerState createState() => _PickerState();
}

class _PickerState extends State<Picker> {
  List<String> subjectlist=["Math","Social","Operating","Communication","Software","Algorithim","Advanced"];
  int selectitem;
  @override
  Widget build(BuildContext context) {
    return  CupertinoPicker(
              children: <Widget>[
                  Center(
                   child: Text("Math",
                   style: GoogleFonts.kaushanScript(
                     color:Colors.black,fontSize:30.0,fontWeight:FontWeight.w300
                   ),
                   ),
                 ),
                   Center(
                 child:  Text("Social",
                 style: GoogleFonts.kaushanScript(
                   color:Colors.black,fontSize:30.0,fontWeight:FontWeight.w300
                 ),
                 ),
                
                 ),
                  Center(
                 child:  Text("Operating",
                 style: GoogleFonts.kaushanScript(
                   color:Colors.black,fontSize:30.0,fontWeight:FontWeight.w300
                 ),
                 ),
            
                 
                 ),
                  Center(
                 child:  Text("Communication",
                 style: GoogleFonts.kaushanScript(
                   color:Colors.black,fontSize:30.0,fontWeight:FontWeight.w300
                 ),
                 ),
                  ),
                   Center(
                 child:  Text("Software",
                 style: GoogleFonts.kaushanScript(
                   color:Colors.black,fontSize:30.0,fontWeight:FontWeight.w300
                 ),
                 ),
                  ),
                   Center(
                 child:  Text("Algorithim",
                 style: GoogleFonts.kaushanScript(
                   color:Colors.black,fontSize:30.0,fontWeight:FontWeight.w300
                 ),
                 ),
                  ),
                     Center(
                 child:  Text("Advanced",
                 style: GoogleFonts.kaushanScript(
                   color:Colors.black,fontSize:30.0,fontWeight:FontWeight.w300
                 ),
                 ),
                  ),
              
              ],
                itemExtent: 50,
                useMagnifier: true,
              onSelectedItemChanged: (int index){
                selectitem =index;
              selectedsubject=subjectlist[selectitem];
              
              },  
              );
  }
}