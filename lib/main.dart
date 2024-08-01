import 'package:flutter/material.dart';
import 'package:mobile_app_test/view/LoginView.dart';
import 'package:mobile_app_test/viewmodel/LoginViewModel.dart';
import 'package:provider/provider.dart'; // Import provider

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => LoginViewModel(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: LoginView(), // Thay đổi ở đây
    );
  }
}
