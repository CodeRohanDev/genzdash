import 'package:flutter/material.dart';

class AnalyticsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Analytics'),
      ),
      body: Center(
        child: Text(
          'Analytics Overview Page',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
