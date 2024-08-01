import 'package:flutter/material.dart';
import '../model/UserService.dart';
import 'LoginView.dart';

class UserHomePage extends StatelessWidget {
  final UserService _userService = UserService();

  Future<void> _logout(BuildContext context) async {
    try {
      await _userService.logout(); // Clear the login status
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => LoginView(), // Navigate back to the login page
        ),
      );
    } catch (e) {
      print('Error logging out: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error logging out. Please try again.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Home Page'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () => _logout(context), // Call the logout function
          ),
        ],
      ),
      body: Center(
        child: Text('Welcome to the user home page!'),
      ),
    );
  }
}
