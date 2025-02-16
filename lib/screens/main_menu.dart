import 'package:flutter/material.dart';
import 'calculator1.dart';
import 'calculator2.dart';

class MainMenuScreen extends StatelessWidget {
  const MainMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Калькулятор палива'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Calculator1Screen()),
                  );
                },
                child: const Text('Калькулятор завдання 1'),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Calculator2Screen()),
                  );
                },
                child: const Text('Калькулятор завдання 2'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}