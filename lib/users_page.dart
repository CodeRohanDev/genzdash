// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UsersPage extends StatefulWidget {
  @override
  _UsersPageState createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');

  String searchQuery = '';
  List<Map<String, dynamic>> allUsers = [];
  List<Map<String, dynamic>> filteredUsers = [];

  @override
  void initState() {
    super.initState();
    fetchUsers();
  }

  void fetchUsers() async {
    usersCollection.get().then((snapshot) {
      setState(() {
        allUsers = snapshot.docs
            .map((doc) => doc.data() as Map<String, dynamic>)
            .toList();
        filteredUsers = allUsers;
      });
    });
  }

  void updateSearchQuery(String newQuery) {
    setState(() {
      searchQuery = newQuery;
      if (searchQuery.isNotEmpty) {
        filteredUsers = allUsers.where((user) {
          final name = user['fullName']?.toLowerCase() ?? '';
          final username = user['username']?.toLowerCase() ?? '';
          final email = user['email']?.toLowerCase() ?? '';
          return name.contains(searchQuery.toLowerCase()) ||
              username.contains(searchQuery.toLowerCase()) ||
              email.contains(searchQuery.toLowerCase());
        }).toList();
      } else {
        filteredUsers = allUsers;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: 'Search by name or username...',
                prefixIcon: Icon(Icons.search),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
              onChanged: updateSearchQuery,
            ),
            SizedBox(height: 16.0),
            Expanded(
              child: Container(
                width: double.infinity, // Make the table span the full width
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: DataTable(
                    columnSpacing: 20.0,
                    headingRowColor: MaterialStateColor.resolveWith(
                      (states) => Colors.blueAccent.shade100,
                    ),
                    dataRowColor: MaterialStateColor.resolveWith(
                      (states) => Colors.white,
                    ),
                    columns: const [
                      DataColumn(label: Text('Full Name')),
                      DataColumn(label: Text('Username')),
                      DataColumn(label: Text('Email')),
                      DataColumn(label: Text('Email Verified')),
                    ],
                    rows: filteredUsers.map((user) {
                      return DataRow(
                        cells: [
                          DataCell(Text(user['fullName'] ?? 'N/A')),
                          DataCell(Text(user['username'] ?? 'N/A')),
                          DataCell(Text(user['email'] ?? 'N/A')),
                          DataCell(
                            Text(user['isVerified'] == true ? 'Yes' : 'No'),
                          ),
                        ],
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
