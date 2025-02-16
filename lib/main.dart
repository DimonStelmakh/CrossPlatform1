import 'package:flutter/material.dart';
import 'screens/main_menu.dart';

void main() {
  runApp(const FuelCalculatorApp());
}

class FuelCalculatorApp extends StatelessWidget {
  const FuelCalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Калькулятор палива',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(),
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
      ),
      home: const MainMenuScreen(),
    );
  }
}