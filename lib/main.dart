import 'package:flutter/material.dart';
import 'features/car_expenses/state/car_expenses_container.dart';
import 'shared/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Учет расходов на авто',
      theme: AppTheme.lightTheme,
      home: const CarExpensesContainer(),
    );
  }
}
