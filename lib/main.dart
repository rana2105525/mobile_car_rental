import 'package:flutter/material.dart';
import 'package:mobile_car_rental/screens/car_detail_screen.dart';
import 'package:mobile_car_rental/screens/home_screen.dart';
import 'package:mobile_car_rental/screens/onboarding_screen.dart';
import 'package:mobile_car_rental/tabs/notification_tab.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Car Rental',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false, // Removes the debug banner
      home: const Onboarding(),
    );
  }
}
