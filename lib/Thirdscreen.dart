
import 'dart:convert';

import 'package:http/http.dart'as http;
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:leczone/Chat1.dart';
import 'package:leczone/Math/math.dart';
import 'package:leczone/global.dart';
//import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:leczone/secondscreen.dart';
import 'package:leczone/userpicker/picker.dart';
import 'package:uuid/uuid.dart';
import 'faculty.dart';
import 'google.dart';

bool a=false;
class Third extends StatefulWidget {
final String selectedsubject;
Third({this.selectedsubject});
  @override
  _ThirdState createState() => _ThirdState();
}

class _ThirdState extends State<Third> {
  
  FirebaseDatabase database =new FirebaseDatabase();
  

  List<String> subjectlist=["Math","Social","Operating","Communication","Software","Algorithim"];
var uid=Uuid();     
 void _showDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return Scaffold(
                  body: AlertDialog(
            title: new Text("Incorrect Email id",
            style: TextStyle(fontSize: 20.0,),
            ),
            content: new Text("Go back to Login page",
            style: TextStyle(fontSize: 15.0),
            ),
            actions: <Widget>[
              // usually buttons at the bottom of the dialog
              new IconButton(
                icon: Icon(Icons.arrow_back_ios
                ),
                onPressed: () {
                   signOutGoogle();
                    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) {return Student1();}), ModalRoute.withName('/'));
                },
              ),
            ],
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14.0)),
            elevation: 20.0,
            contentPadding:EdgeInsets.all(10.0) ,
          
          ),
        );
      },
    );
  }

 var data=List<Data>();
Data userdict;

Future<List<Data>> fetchPost() async {
  final response =
      await http.get('https://raw.githubusercontent.com/shubham64mehta/LecZone2-done-in-fluttter-/master/Faculty%20Database%20.json');

  if (response.statusCode == 200) {
    var rb = response.body;

    // store json data into list
    var list = json.decode(rb) as List;
    // iterate over the list and map each object in list to Img by calling Img.fromJson
    List<Data> users = list.map((i)=>Data.fromJson(i)).toList();
    
    data = users;
check();
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load post');
  }
}

void check()
{
  bool flag = false;
for (var i=0; i<data.length;i++)
{
  if (data[i].email == email)
  {
     flag = true;
    break;
  }
  
}
if (!flag)
{
  _showDialog();
}

}



  Future uploadToStorage() async {
try {
  final DateTime now = DateTime.now();
  final int millSeconds = now.millisecondsSinceEpoch;
  final String month = now.month.toString();
  final String date = now.day.toString();
  final String storageId = (millSeconds.toString() + uid.toString());
  final String today = ('$month-$date'); 

 final file =  await ImagePicker.pickVideo(source: ImageSource.gallery);
 uploadVideo(file);

} catch (error) {
  print(error);
  }

}
String downloadUrl;
Future<String>uploadVideo(var videofile)async{
   var uuid = new Uuid().v1();
  StorageReference ref = FirebaseStorage.instance.ref().child("post_$uuid.jpg");
  
  await ref.put(videofile).onComplete.then((val) {
                
                val.ref.getDownloadURL().then((val) {
                  print(val);
                  downloadUrl = val;
                
                    addUrl(downloadUrl);//Val here is Already String
                });
              });
  return downloadUrl;

}

  
Future<void> addUrl(String videourl) async {
 
  var uuid = new Uuid().v1();
   DatabaseReference _subjects = database.reference().child("Subjects").child(selectedsubject).child(uuid);
  //var uploadUrl = uploadVideo(file)
  final TransactionResult transactionResult =
        await _subjects.runTransaction((MutableData mutableData) async {
      mutableData.value = (mutableData.value ?? 0) + 1;

      return mutableData;
    });

    if (transactionResult.committed) {
      _subjects.push().set(<String, String>{
        "videourl": "true",
      }).then((_) {
        print('Transaction  committed.');
        a=true;
      });
    } else {
      print('Transaction not committed.');
      if (transactionResult.error != null) {
        print(transactionResult.error.message);
      }
    }
    _subjects.set(
      {
        "videoUrl": videourl,
      }
    );
    print('Data uploaded successfully');
    print('Retrieving data now...\n');
   // db = FirebaseDatabase.instance.reference().child("zoom_users");
   DatabaseReference db = FirebaseDatabase.instance.reference().child("Subjects").child("Math");
    db.once().then((DataSnapshot snapshot){    
    
    values = snapshot.value;
    print(values.length);

    
 });
  }
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      drawer:     Drawer(
        child: Container(
        child: Center(
          child: Column(
            children: <Widget>[
              SizedBox(height: 40,),
              CircleAvatar(
                backgroundImage: NetworkImage(
                  imageUrl,
                ),
                radius: 60,
                backgroundColor: Colors.transparent,
              ),
              SizedBox(height: 40),
              Text(
                'NAME',
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              Text(
                name,
                style: TextStyle(
                    fontSize: 25,
                    color: Colors.deepPurple,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Text(
                'EMAIL',
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              FittedBox(
                child: Text(
                   email,
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.deepPurple,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 40),
              RaisedButton(
                onPressed: () {
                  signOutGoogle();
                  Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) {return Student1();}), ModalRoute.withName('/'));
                },
                color: Colors.deepPurple,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Sign Out',
                    style: TextStyle(fontSize: 25, color: Colors.white),
                  ),
                ),
                elevation: 5,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40)),
              ),
            ],
          ),
        ),
      ),
      ),
      body: Column(
        children: <Widget>[
          SizedBox(height:280),
            Center(
              child: RaisedButton(
                 color: Colors.blue,
                 elevation: 20.0,
                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14.0)),
                 child: Container(
                   width: 250,
                   height: 60,
                   child: Center(
                     child: Text("Select Subject",
                     style: TextStyle(color: Colors.white,fontSize: 20.0,fontWeight: FontWeight.bold),
                     ),
                   ),
                   decoration: BoxDecoration(
                     borderRadius: BorderRadius.circular(14.0)
                   ),
                 ),
                 onPressed: (){
                  // uploadToStorage();
                   //_showDialog();
                   showModalBottomSheet(context: context, builder: (BuildContext builder){
                     return Scaffold(
                       appBar: AppBar(
                         elevation: 0.0,
                         actions: <Widget>[
                           IconButton(
                             icon:Icon(Icons.send),
                             onPressed: (){
                               //selectedsubject = 
                               uploadToStorage();
                              
                               
                             },
                           )
                         ],
                       ),
                       body: Picker(),
                     );
                   },
                   elevation: 15.0,
                   shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(23.0))
                   );
                   //addUrl();
                   
                 }
               ),
            ),
              SizedBox(height: 50,),
                Center(
                  child: RaisedButton(
               color: Colors.blue,
               elevation: 20.0,
               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14.0)),
               child: Container(
                   width: 250,
                   height: 60,
                   child: Center(
                     child: Text("Message",
                     style: TextStyle(color: Colors.white,fontSize: 20.0,fontWeight: FontWeight.bold),
                     ),
                   ),
                   decoration: BoxDecoration(
                     borderRadius: BorderRadius.circular(14.0)
                   ),
               ),
               onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder:(context)=>LoginScreen()));
               },
             ),
                ),
        ],
      ),
      
    );
    
  }
  
}