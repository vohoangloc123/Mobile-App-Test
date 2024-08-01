import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

class UserService {
  Future<List<Map<String, dynamic>>> loadUsers() async {
    try {
      final jsonString = await rootBundle.loadString('assets/users.json');
      final Map<String, dynamic> jsonResponse = json.decode(jsonString);

      // Kiểm tra xem 'users' có tồn tại và có kiểu danh sách
      final List<dynamic>? usersList = jsonResponse['users'] as List<dynamic>?;
      if (usersList != null) {
        return usersList.map((e) => e as Map<String, dynamic>).toList();
      } else {
        throw Exception('Invalid JSON structure: "users" is missing or not a list');
      }
    } catch (e) {
      print('Error loading users: $e');
      throw e;
    }
  }

  Future<bool> validateUser(String email, String password) async {
    try {
      // Tải danh sách người dùng
      final users = await loadUsers();

      // In ra danh sách người dùng để kiểm tra
      print('Loaded users: $users');

      // Kiểm tra từng người dùng
      for (var user in users) {
        print('Checking user: $user');
        if (user['email'] == email && user['password'] == password) {
          print('User credentials match for: $email');
          return true; // Credentials match
        }
      }

      // Nếu không có người dùng nào khớp
      print('No matching credentials found for: $email');
      return false; // Credentials do not match
    } catch (e) {
      print('Error validating user: $e');
      return false;
    }
  }
}
