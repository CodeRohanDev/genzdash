// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String? errorMessage;

  Future<void> _login() async {
    try {
      String username = _usernameController.text.trim();
      String password = _passwordController.text;

      // Validate inputs
      if (username.isEmpty || password.isEmpty) {
        setState(() {
          errorMessage = 'Please enter both username and password.';
        });
        return;
      }

      // Query Firestore for the user document by username
      QuerySnapshot userQuery = await _firestore
          .collection('admin')
          .where('username', isEqualTo: username)
          .get();

      // Check if any document was found
      if (userQuery.docs.isNotEmpty) {
        DocumentSnapshot userDoc = userQuery.docs.first;

        // Validate password
        if (userDoc['password'] == password) {
          // Sign in with Firebase
          await _auth.signInWithEmailAndPassword(
            email: username +
                '@genzgems.com', // Assuming you want to use a domain for Firebase
            password: password,
          );
          Navigator.pushReplacementNamed(context, '/dashboard');
        } else {
          setState(() {
            errorMessage = 'Incorrect password. Please try again.';
          });
        }
      } else {
        setState(() {
          errorMessage = 'Username not found. Please try again.';
        });
      }
    } catch (e) {
      print('Error during login: $e'); // Log the error
      setState(() {
        errorMessage = 'Failed to log in. Please try again.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[50],
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.lock_outline, size: 80, color: Colors.blueAccent),
                SizedBox(height: 10),
                Text(
                  'Login to Gen Z Gems',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueAccent,
                  ),
                ),
                SizedBox(height: 20),
                Center(
                  child: SizedBox(
                    width: 350, // Adjust this width as needed
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 4,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            TextField(
                              controller: _usernameController,
                              decoration: InputDecoration(
                                labelText: 'Username',
                                prefixIcon: Icon(Icons.person),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                            SizedBox(height: 15),
                            TextField(
                              controller: _passwordController,
                              decoration: InputDecoration(
                                labelText: 'Password',
                                prefixIcon: Icon(Icons.lock),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              obscureText: true,
                            ),
                            SizedBox(height: 20),
                            ElevatedButton(
                              onPressed: _login,
                              style: ElevatedButton.styleFrom(
                                minimumSize: Size(double.infinity, 50),
                                backgroundColor: Colors.blueAccent,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: Text(
                                'Login',
                                style: TextStyle(fontSize: 18),
                              ),
                            ),
                            if (errorMessage != null) ...[
                              SizedBox(height: 15),
                              Text(
                                errorMessage!,
                                style: TextStyle(color: Colors.red),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, '/registration');
                                },
                                child: Text(
                                    'Don\'t have an account? Register here!'),
                              )
                            ],
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
