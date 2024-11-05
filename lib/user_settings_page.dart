import 'package:flutter/material.dart';

class UserSettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Settings'),
      ),
      body: Center(
        child: Text(
          'User Settings Page',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
