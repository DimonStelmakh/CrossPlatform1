import 'package:flutter/material.dart';
import '../widgets/number_input_field.dart';
import '../models/calculation_results.dart';

class Calculator1Screen extends StatefulWidget {
  const Calculator1Screen({super.key});

  @override
  State<Calculator1Screen> createState() => _Calculator1ScreenState();
}

class _Calculator1ScreenState extends State<Calculator1Screen> {
  final _formKey = GlobalKey<FormState>();
  final _controllers = <String, TextEditingController>{
    'H': TextEditingController(),
    'C': TextEditingController(),
    'S': TextEditingController(),
    'N': TextEditingController(),
    'O': TextEditingController(),
    'W': TextEditingController(),
    'A': TextEditingController(),
  };

  Task1Result? _result;

  void _calculate() {
    if (!_formKey.currentState!.validate()) return;

    final input = Task1Input(
      h: double.parse(_controllers['H']!.text),
      c: double.parse(_controllers['C']!.text),
      s: double.parse(_controllers['S']!.text),
      n: double.parse(_controllers['N']!.text),
      o: double.parse(_controllers['O']!.text),
      w: double.parse(_controllers['W']!.text),
      a: double.parse(_controllers['A']!.text),
    );

    setState(() {
      _result = calculateTask1(input);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Калькулятор 1'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              NumberInputField(
                controller: _controllers['H']!,
                label: 'Водень (H), %',
              ),
              const SizedBox(height: 8),
              NumberInputField(
                controller: _controllers['C']!,
                label: 'Вуглець (C), %',
              ),
              const SizedBox(height: 8),
              NumberInputField(
                controller: _controllers['S']!,
                label: 'Сірка (S), %',
              ),
              const SizedBox(height: 8),
              NumberInputField(
                controller: _controllers['N']!,
                label: 'Азот (N), %',
              ),
              const SizedBox(height: 8),
              NumberInputField(
                controller: _controllers['O']!,
                label: 'Кисень (O), %',
              ),
              const SizedBox(height: 8),
              NumberInputField(
                controller: _controllers['W']!,
                label: 'Волога (W), %',
              ),
              const SizedBox(height: 8),
              NumberInputField(
                controller: _controllers['A']!,
                label: 'Зола (A), %',
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _calculate,
                child: const Text('Розрахувати'),
              ),
              if (_result != null) ...[
                const SizedBox(height: 24),
                _buildResultsSection('Суха маса', [
                  'Водень (H): ${_result!.dryMass.h.toStringAsFixed(2)}%',
                  'Вуглець (C): ${_result!.dryMass.c.toStringAsFixed(2)}%',
                  'Сірка (S): ${_result!.dryMass.s.toStringAsFixed(2)}%',
                  'Азот (N): ${_result!.dryMass.n.toStringAsFixed(2)}%',
                  'Кисень (O): ${_result!.dryMass.o.toStringAsFixed(2)}%',
                  'Зола (A): ${_result!.dryMass.a.toStringAsFixed(2)}%',
                ]),
                const SizedBox(height: 16),
                _buildResultsSection('Горюча маса', [
                  'Водень (H): ${_result!.combustibleMass.h.toStringAsFixed(2)}%',
                  'Вуглець (C): ${_result!.combustibleMass.c.toStringAsFixed(2)}%',
                  'Сірка (S): ${_result!.combustibleMass.s.toStringAsFixed(2)}%',
                  'Азот (N): ${_result!.combustibleMass.n.toStringAsFixed(2)}%',
                  'Кисень (O): ${_result!.combustibleMass.o.toStringAsFixed(2)}%',
                ]),
                const SizedBox(height: 16),
                _buildResultsSection('Теплота згоряння', [
                  'Нижча робоча теплота згоряння: ${_result!.heatingValue.working.toStringAsFixed(1)} кДж/кг',
                  'Нижча суха теплота згоряння: ${_result!.heatingValue.dry.toStringAsFixed(1)} кДж/кг',
                  'Нижча горюча теплота згоряння: ${_result!.heatingValue.combustible.toStringAsFixed(1)} кДж/кг',
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
