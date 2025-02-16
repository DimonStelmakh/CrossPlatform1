import 'package:flutter/material.dart';
import '../widgets/number_input_field.dart';
import '../models/calculation_results.dart';

class Calculator2Screen extends StatefulWidget {
  const Calculator2Screen({super.key});

  @override
  State<Calculator2Screen> createState() => _Calculator2ScreenState();
}

class _Calculator2ScreenState extends State<Calculator2Screen> {
  final _formKey = GlobalKey<FormState>();
  final _controllers = <String, TextEditingController>{
    'C': TextEditingController(),
    'H': TextEditingController(),
    'O': TextEditingController(),
    'S': TextEditingController(),
    'A': TextEditingController(),
    'W': TextEditingController(),
    'V': TextEditingController(),
    'Qi_daf': TextEditingController(),
  };

  Task2Result? _result;

  void _calculate() {
    if (!_formKey.currentState!.validate()) return;

    final input = Task2Input(
      c: double.parse(_controllers['C']!.text),
      h: double.parse(_controllers['H']!.text),
      o: double.parse(_controllers['O']!.text),
      s: double.parse(_controllers['S']!.text),
      ad: double.parse(_controllers['A']!.text),
      wr: double.parse(_controllers['W']!.text),
      v: double.parse(_controllers['V']!.text),
      qiDaf: double.parse(_controllers['Qi_daf']!.text),
    );

    setState(() {
      _result = calculateTask2(input);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Калькулятор 2'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              NumberInputField(
                controller: _controllers['C']!,
                label: 'Вуглець у горючій масі (C), %',
              ),
              const SizedBox(height: 8),
              NumberInputField(
                controller: _controllers['H']!,
                label: 'Водень у горючій масі (H), %',
              ),
              const SizedBox(height: 8),
              NumberInputField(
                controller: _controllers['O']!,
                label: 'Кисень у горючій масі (O), %',
              ),
              const SizedBox(height: 8),
              NumberInputField(
                controller: _controllers['S']!,
                label: 'Сірка у горючій масі (S), %',
              ),
              const SizedBox(height: 8),
              NumberInputField(
                controller: _controllers['A']!,
                label: 'Зола у сухій масі (A), %',
              ),
              const SizedBox(height: 8),
              NumberInputField(
                controller: _controllers['W']!,
                label: 'Волога у робочій масі (W), %',
              ),
              const SizedBox(height: 8),
              NumberInputField(
                controller: _controllers['V']!,
                label: 'Ванадій (V), мг/кг',
              ),
              const SizedBox(height: 8),
              NumberInputField(
                controller: _controllers['Qi_daf']!,
                label: 'Нижча теплота згоряння горючої маси (Qi_daf), МДж/кг',
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _calculate,
                child: const Text('Розрахувати'),
              ),
              if (_result != null) ...[
                const SizedBox(height: 24),
                _buildResultsSection('Склад робочої маси', [
                  'Вуглець (C): ${_result!.workingMass.c.toStringAsFixed(2)} відсотків',
                  'Водень (H): ${_result!.workingMass.h.toStringAsFixed(2)} відсотків',
                  'Кисень (O): ${_result!.workingMass.o.toStringAsFixed(2)} відсотків',
                  'Сірка (S): ${_result!.workingMass.s.toStringAsFixed(2)} відсотків',
                  'Зола (A): ${_result!.workingMass.a.toStringAsFixed(2)} відсотків',
                  'Ванадій (V): ${_result!.workingMass.v.toStringAsFixed(2)} мг/кг',
                ]),
                const SizedBox(height: 16),
                _buildResultsSection('Теплота згоряння', [
                  'Нижча робоча теплота згоряння: ${_result!.qiR.toStringAsFixed(3)} МДж/кг',
                ]),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildResultsSection(String title, List<String> items) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            ...items.map((item) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Text(item),
            )),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    for (var controller in _controllers.values) {
      controller.dispose();
    }
    super.dispose();
  }
}