
class Data {
  final String id;
  final String name;
  final String email;

  Data({this.id, this.name, this.email,});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      id: json['id'],
      name: json['name'],
      email: json['email'],
    );
  }
}