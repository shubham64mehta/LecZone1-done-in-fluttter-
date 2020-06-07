
class Data {
  final String name;
  final String email;

  Data({ this.name, this.email,});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      name: json['name'],
      email: json['email'],
    );
  }
}