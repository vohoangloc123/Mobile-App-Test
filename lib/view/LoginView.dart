
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/UserService.dart';
import '../viewmodel/LoginViewModel.dart';
import 'UserHomePage.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final UserService _userService = UserService();
  bool _isLoading = true;
  bool _isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    try {
      _isLoggedIn = await _userService.getLoginStatus();
      if (_isLoggedIn) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => UserHomePage(),
          ),
        );
      } else {
        setState(() {
          _isLoading = false; // Dừng tải khi trạng thái được kiểm tra
        });
      }
    } catch (e) {
      print('Error checking login status: $e');
      setState(() {
        _isLoading = false; // Dừng tải do lỗi
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final loginViewModel = Provider.of<LoginViewModel>(context);

    if (_isLoading) {
      return Scaffold(
        body: Center(child: CircularProgressIndicator()), // Hiển thị loading indicator
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              onChanged: (value) {
                loginViewModel.email = value;
              },
              decoration: InputDecoration(
                labelText: 'Email',
                errorText: loginViewModel.emailError,
              ),
            ),
            SizedBox(height: 16),
            TextField(
              obscureText: true,
              onChanged: (value) {
                loginViewModel.password = value;
              },
              decoration: InputDecoration(
                labelText: 'Password',
                errorText: loginViewModel.passwordError,
              ),
            ),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: () async {
                bool isValid = await loginViewModel.validateCredentials();
                if (isValid) {
                  await _userService.saveLoginStatus(true);
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => UserHomePage(),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Login failed. ${loginViewModel.emailError ?? loginViewModel.passwordError}'),
                    ),
                  );
                }
              },
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
