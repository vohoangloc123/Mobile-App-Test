import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodel/LoginViewModel.dart';
import 'UserHomePage.dart';

class LoginView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final loginViewModel = Provider.of<LoginViewModel>(context);

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
            )
          ],
        ),
      ),
    );
  }
}
