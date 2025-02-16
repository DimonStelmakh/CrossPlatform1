import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NumberInputField extends StatelessWidget {
  final TextEditingController controller;
  final String label;

  const NumberInputField({
    super.key,
    required this.controller,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
      ),
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
      ],
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Будь ласка, введіть значення';
        }
        final number = double.tryParse(value);
        if (number == null) {
          return 'Будь ласка, введіть коректне число';
        }
        if (number < 0 || number > 100) {
          return 'Значення має бути від 0 до 100';
        }
        return null;
      },
    );
  }
}