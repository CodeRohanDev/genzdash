import 'package:flutter/material.dart';

class Maindash extends StatefulWidget {
  const Maindash({super.key});

  @override
  State<Maindash> createState() => _MaindashState();
}

class _MaindashState extends State<Maindash> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("this is the main dashboard"),
      ),
    );
  }
}
