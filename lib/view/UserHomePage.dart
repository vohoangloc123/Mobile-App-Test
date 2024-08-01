import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Home Page'),
      ),
      body: Center(
        child: Text('Welcome to the user home page!'),
      ),
    );
  }
}