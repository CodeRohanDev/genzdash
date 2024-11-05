// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:genzdash/admin_page.dart';
import 'package:genzdash/analytics_page.dart';
import 'package:genzdash/maindash.dart';
import 'package:genzdash/users_page.dart';

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  int _selectedIndex = 0; // To keep track of the selected index for navigation

  // List of pages for navigation
  final List<Widget> _pages = [
    Maindash(),
    UsersPage(),
    AdminPage(),
    AnalyticsPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex =
          index; // Update the selected index when a navigation item is tapped
    });
  }

  @override
  Widget build(BuildContext context) {
    // Get the current user
    User? user = _auth.currentUser;

    return Scaffold(
      body: Row(
        children: [
          // Sidebar navigation
          Container(
            width: 200,
            color: Colors.blueAccent,
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                DrawerHeader(
                  child: Text(
                    'Menu',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                  decoration: BoxDecoration(
                    color: Colors.blueAccent,
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.dashboard, color: Colors.white),
                  title:
                      Text('Dashboard', style: TextStyle(color: Colors.white)),
                  onTap: () => _onItemTapped(0),
                ),
                ListTile(
                  leading: Icon(Icons.group, color: Colors.white),
                  title: Text('Users', style: TextStyle(color: Colors.white)),
                  onTap: () => _onItemTapped(1),
                ),
                ListTile(
                  leading:
                      Icon(Icons.admin_panel_settings, color: Colors.white),
                  title: Text('Admin', style: TextStyle(color: Colors.white)),
                  onTap: () => _onItemTapped(2),
                ),
                ListTile(
                  leading: Icon(Icons.analytics, color: Colors.white),
                  title:
                      Text('Analytics', style: TextStyle(color: Colors.white)),
                  onTap: () => _onItemTapped(3),
                ),
              ],
            ),
          ),
          // Main content area
          Expanded(
            child: IndexedStack(
              index: _selectedIndex,
              children: _pages,
            ),
          ),
        ],
      ),
    );
  }
}
