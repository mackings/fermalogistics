import 'dart:convert';



class UserModel {

  final String? id;
  final String? name;
  final String? picture;
  final String? email;
  final String? phoneNumber;

  UserModel({
    this.id,
    this.name,
    this.picture,
    this.email,
    this.phoneNumber,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String?,
      name: json['name'] as String?,
      picture: json['picture'] as String?,
      email: json['email'] as String?,
      phoneNumber: json['phoneNumber']?.toString(), // Convert to string safely
    );
  }

  static List<UserModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => UserModel.fromJson(json)).toList();
  }
}
