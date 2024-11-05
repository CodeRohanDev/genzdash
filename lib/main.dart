import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:genzdash/admin_page.dart';
import 'package:genzdash/analytics_page.dart';
import 'package:genzdash/dashboard_page.dart';
import 'package:genzdash/firebase_options.dart';
import 'package:genzdash/login_page.dart';
import 'package:genzdash/registration_page.dart';
import 'package:genzdash/statistics_page.dart';
import 'package:genzdash/user_settings_page.dart';
import 'package:genzdash/users_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gen Z Gems Dashboard',
      initialRoute: '/',
      routes: {
        '/': (context) => LoginPage(),
        '/registration': (context) => RegistrationPage(),
        '/dashboard': (context) => DashboardPage(),
        '/userSettings': (context) => UserSettingsPage(),
        '/statistics': (context) => StatisticsPage(),
        '/users': (context) => UsersPage(), // Define UsersPage
        '/admin': (context) => AdminPage(), // Define AdminPage
        '/analytics': (context) => AnalyticsPage(), // Define AnalyticsPage
      },
    );
  }
}
