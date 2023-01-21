import 'package:flutter/material.dart';

class CustomTextFields {
  late TextEditingController _emailController;
  late TextEditingController _passController;
  late TextEditingController _userNameController;

  CustomTextFields() {
    _emailController = TextEditingController();
    _passController = TextEditingController();
    _userNameController = TextEditingController();
  }

  Widget emailField() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
      child: TextField(
        controller: _emailController,
        style: TextStyle(color: Colors.black),
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          hintText: "Email",
          hintStyle: TextStyle(color: Colors.black45),
          filled: true,
          fillColor: Colors.white,
        ),
      ),
    );
  }

  Widget passField() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
      child: TextField(
        controller: _passController,
        style: TextStyle(color: Colors.black),
        obscureText: true,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          hintText: "Password",
          hintStyle: TextStyle(color: Colors.black45),
          filled: true,
          fillColor: Colors.white,
        ),
      ),
    );
  }

  Widget userNameField() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
        child: TextField(
        controller: _userNameController,
        style: TextStyle(color: Colors.black),
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          hintText: "Username",
          hintStyle: TextStyle(color: Colors.black45),
          filled: true,
          fillColor: Colors.white,
        ),
      )
    );
  }

  get passText => _passController.text;

  get emailText => _emailController.text;

  get userText => _userNameController.text;

  set userNameController(value) {
    _userNameController.text = value;
  }

  set passController(value) {
    _passController.text = value;
  }

  set emailController(value) {
    _emailController.text = value;
  }
}