/*class Data{
  String id;
  String name;
  String email;
  List subjects;

  Data(this.id,this.email,this.name,this.subjects);

  Data.fromjson(Map<String,dynamic> json){    //converts json to map
  id=json['id'] ;
  name=json['name'];
  email=json['email'];
  subjects=json['subjects'];
  }
}*///this one is for student ok wait 
class Post {
  final String id;
  final String name;
  final String email;
  List subjects;

  Post({this.id, this.name, this.email, this.subjects});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      subjects: json['subjects'],
    );
  }
}

