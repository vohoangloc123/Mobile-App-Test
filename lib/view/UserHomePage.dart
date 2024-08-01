import 'package:flutter/material.dart';

import '../model/UserService.dart';
import 'LoginView.dart';

class UserHomePage extends StatefulWidget {
  @override
  _UserHomePageState createState() => _UserHomePageState();

}

class _UserHomePageState extends State<UserHomePage> {
  final UserService _userService = UserService();
  List<Map<String, String>> items = List.generate(
    10,
        (index) => {'title': 'Item ${index + 1}', 'subtitle': 'Details about item ${index + 1}', 'date': '2024-08-${index + 1}'},
  );

  bool isLoadingMore = false;

  Future<void> _refreshList() async {
    // Mô phỏng load dữ liệu qua mạng
    await Future.delayed(Duration(seconds: 1));
    setState(() {
      items = List.generate(
        10,
            (index) => {'title': 'Item ${index + 1}', 'subtitle': 'Details about item ${index + 1}', 'date': '2024-08-${index + 1}'},
      );
    });
  }

  void _loadMore() {
    if (!isLoadingMore) {
      setState(() {
        isLoadingMore = true;
      });
      // Mô phỏng load dữ liệu qua mạng
      Future.delayed(Duration(seconds: 2), () {
        setState(() {
          items.addAll(List.generate(
            10,
                (index) => {'title': 'Item ${items.length + index + 1}', 'subtitle': 'Details about item ${items.length + index + 1}', 'date': '2024-08-${items.length + index + 1}'},
          ));
          isLoadingMore = false;
        });
      });
    }
  }

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
            onPressed: () => _logout(context),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _refreshList,
        child: ListView.builder(
          itemCount: items.length + 1,
          itemBuilder: (context, index) {
            if (index == items.length) {
              return isLoadingMore
                  ? Center(child: CircularProgressIndicator())
                  : ElevatedButton(
                onPressed: _loadMore,
                child: Text('Load More'),
              );
            }
            final item = items[index];
            return ListTile(
              title: Text(item['title']!),
              subtitle: Text(item['subtitle']!),
              trailing: Text(item['date']!),
            );
          },
        ),
      ),
    );
  }
}