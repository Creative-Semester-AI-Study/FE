import 'dart:convert';

class UserModel {
  late int grade;
  late int id;
  late String name;
  late String department;
  late String status;
  late String token;

  UserModel({
    required this.grade,
    required this.name,
    required this.id,
    required this.department,
    required this.status,
    required this.token,
  });

  Map<String, dynamic> toJson() {
    return {
      'grade': grade,
      'id': id,
      'name': name,
      'department': department,
      'status': status,
      'token': token,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      grade: int.parse(json['grade'].toString()),
      id: int.parse(json['id'].toString()),
      name: json['name'],
      department: json['department'],
      status: json['status'],
      token: json['token'],
    );
  }
}
