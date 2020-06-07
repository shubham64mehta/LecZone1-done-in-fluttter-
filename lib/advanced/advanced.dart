import 'dart:collection';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:leczone/global.dart';
import 'package:uuid/uuid.dart';

int index1;

class Advanced extends StatefulWidget {
  @override
  _MathState createState() => _MathState();
}

class _MathState extends State<Advanced> with SingleTickerProviderStateMixin {
  
  Animation _listAnimation;
  AnimationController _controller;
  Future<String>add()async{
     FirebaseDatabase.instance.reference().child("Subjects").child("Advanced").once().then((DataSnapshot snapshot){
       
       values = snapshot.value;
       array5.clear();
       values.forEach((key, value) {

         FirebaseDatabase.instance.reference().child("Subjects").child("Advanced").child(key).child('videoUrl').once().then((DataSnapshot s){//run
          array5.add(s.value);
          

       }); 
  
      
    });//run
      
    });
    return 'success';
  }
 
  @override
  void initState() {
    super.initState();
    add();
    _controller =
       AnimationController(vsync: this, duration: Duration(seconds: 4));
       _listAnimation = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
       parent: _controller,
       curve: Interval(0.40, 0.75, curve: Curves.easeOut)));

             _controller.forward();
   _controller.addListener(() {
     setState(() {});
   });
  }
 
  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      body: Opacity(
        opacity: _listAnimation.value,
              child: ListView.builder(
          itemCount: array5.length,
          itemBuilder: (context,index){
            return ChewieListItem(videoPlayerController: VideoPlayerController.network(array5[index]),looping: true,);
          }),
      )
    );
    
  }
}
class ChewieListItem extends StatefulWidget {
  // This will contain the URL/asset path which we want to play
  final VideoPlayerController videoPlayerController;
  final bool looping;

  ChewieListItem({
    @required this.videoPlayerController,
    this.looping,
    Key key,
  }) : super(key: key);

  @override
  _ChewieListItemState createState() => _ChewieListItemState();
}

class _ChewieListItemState extends State<ChewieListItem> {
  ChewieController _chewieController;

  @override
  void initState() {
    super.initState();
    // Wrapper on top of the videoPlayerController
    _chewieController = ChewieController(
      videoPlayerController: widget.videoPlayerController,
      aspectRatio: 16 / 9,
      // Prepare the video to be played and display the first frame
      autoInitialize: true,
      looping: widget.looping,
      // Errors can occur for example when trying to play a video
      // from a non-existent URL
      errorBuilder: (context, errorMessage) {
        return Center(
          child: Text(
            errorMessage,
            style: TextStyle(color: Colors.white),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Chewie(
        controller: _chewieController,
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    // IMPORTANT to dispose of all the used resources
    widget.videoPlayerController.dispose();
    _chewieController.dispose();
  }
}
