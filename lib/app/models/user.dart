import 'package:flutter/foundation.dart';

class UserModel {
  String fullname;
  String username;
  String email;
  String androidToken;
  final String token;
  final int id;

  UserModel(
      {@required this.id,
      this.token,
      this.androidToken,
      @required this.fullname,
      @required this.username,
      @required this.email});

  factory UserModel.fromJson(
      {String fullname,
      String username,
      String email,
      int id,
      String smartphoneToken}) {
    return UserModel(
      androidToken: smartphoneToken,
      email: email,
      fullname: fullname,
      username: username,
      id: id,
    );
  }
}
