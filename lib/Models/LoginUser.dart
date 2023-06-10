import 'dart:io';

class LoginUser {
  String? username;
  String? email;
  String? password;
  File? image;
  String? onlineImage;

  LoginUser._privateConstructor();
  static final LoginUser _instance = LoginUser._privateConstructor();
  static LoginUser get instance => _instance;

}
