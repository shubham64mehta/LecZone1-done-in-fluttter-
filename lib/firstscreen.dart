import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:leczone/Desgin/desgin.dart';
import 'package:leczone/Math/math.dart';
import 'package:leczone/Operating/Operating.dart';
import 'package:leczone/Social/social.dart';
import 'package:leczone/Software/software.dart';
import 'package:leczone/advanced/advanced.dart';
import 'package:leczone/communication/communication.dart';
import 'package:leczone/student.dart';
import 'Chat1.dart';
import 'entities.dart';
import 'google.dart';
import 'package:http/http.dart'as http;

var updatename="";
var flag = 1;
class FirstScreen extends StatefulWidget {
  @override
  _FirstScreenState createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {

  List color=[Colors.red[400],
  Colors.blueAccent[400],
  Colors.cyan[200],
  Colors.purple[400],
  Colors.orange[400],
  Colors.pinkAccent[400],
  Colors.yellow[400],
  Colors.lightBlue[400],
  Colors.deepPurple[400]
  ];

  void _showDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return Scaffold(
                  body: AlertDialog(
            title: new Text("Select SRM ID",
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
                    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) {return Student();}), ModalRoute.withName('/'));
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
//like this Wait dont do anything. i have another logic. If that doesnt woerk I will commit suicide 

var data=List<Post>();
Post userdict;

Future<List<Post>> fetchPost() async {
  final response =
      await http.get('https://raw.githubusercontent.com/shubham64mehta/LecZone2-done-in-fluttter-/master/StudentDatabse.json');

  if (response.statusCode == 200) {
    var rb = response.body;

    // store json data into list
    var list = json.decode(rb) as List;
    // iterate over the list and map each object in list to Img by calling Img.fromJson
    List<Post> users = list.map((i)=>Post.fromJson(i)).toList();
    
    data = users;
check();
    return data;
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
     updatename=data[i].name;
     userdict=data[i] ; 
     flag = true;
    break;
  }
  
}
if (!flag)
{
  _showDialog();
}

}

 Future<List<Post>> post;

  @override
  void initState() {
    super.initState();
    post = fetchPost();
  }
  @override
  Widget build(BuildContext context) { 
    return Scaffold(
      appBar:AppBar(
        elevation: 0.0,
       backgroundColor: Colors.transparent,
       actions: <Widget>[
         IconButton(
           icon: Icon(Icons.message),
           onPressed: ()
           {
             Navigator.push(context, MaterialPageRoute(builder: (context)=>Chat1()));
           },
         )
       ],
        ),
      drawer:    Drawer(
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
                style: GoogleFonts.pacifico(
                                color: Colors.deepPurple,
                                fontSize: 25.0,
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.w500,
                              )
              ),
              SizedBox(height: 20),
              Text(
                'EMAIL',
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              Text(
                email,
                style: GoogleFonts.pacifico(
                                color: Colors.deepPurple,
                                fontSize: 25.0,
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.w500,
                              )
              ),
              SizedBox(height: 40),
              RaisedButton(
                onPressed: () {
                  signOutGoogle();
                  Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) {return Student();}), ModalRoute.withName('/'));
                },
                color: Colors.deepPurple,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Sign Out',
                    style: GoogleFonts.pacifico(
                                color: Colors.white,
                                fontSize: 25.0,
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.w500,
                              )
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
      body: Center(
         child: FutureBuilder<List<Post>>(
            future: post,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
        itemBuilder: (context, index){
          return InkWell(
                      child: Card(
                elevation: 15.0,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(23.0)),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height/5,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(23.0),
                    color: color[index],
                    ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                       Center(
                          child: FittedBox(
                               child: Text(
                              userdict.subjects[index],
                              style: GoogleFonts.pacifico(
                                color: Colors.black,
                                fontSize: 25.0,
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.w500,
                              )
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              onTap: ()
              {
                if(userdict.subjects[index]=="Probability and Queuing Theory")
                {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>Math()));
                }
                if(userdict.subjects[index]=="Social Engineering")
                {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>Social()));
                }
                if(userdict.subjects[index]=="Operating System")
                {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>Operating()));
                }
                if(userdict.subjects[index]=="Desgin and Analysis of Algorithim")
                {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>Desgin()));
                }
                if(userdict.subjects[index]=="Computer Communication")
                {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>Communication()));
                }
                if(userdict.subjects[index]=="Advanced Progaramming Practice")
                {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>Advanced()));
                }
                if(userdict.subjects[index]=="Software Engineering and Project Management")
                {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>Software()));
                }
              },
          );
        },
        itemCount: userdict.subjects.length,
      );


              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }

              // By default, show a loading spinner.
              return CircularProgressIndicator();
            },
          ),
        )
       );
  }
}
