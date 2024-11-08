import 'package:flutter/material.dart';
import 'package:medicine_recommendation/screen/about_screen.dart';
import 'package:medicine_recommendation/screen/contact_screen.dart';
import 'package:medicine_recommendation/screen/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Disease Prediction App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(),
        '/about': (context) => AboutScreen(),
        '/contact': (context) => ContactScreen(),
        // Add more routes as needed for additional screens
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
