import 'package:flutter/material.dart';
import '../models/expense_model.dart';
import '../widgets/expense_table.dart';

class CarExpensesScreen extends StatelessWidget {
  final List<ExpenseModel> expenses;
  final double totalAmount;
  final VoidCallback onAddExpense;
  final ValueChanged<String>? onRemove;

  const CarExpensesScreen({
    super.key,
    required this.expenses,
    required this.totalAmount,
    required this.onAddExpense,
    this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Расходы: ${totalAmount.toStringAsFixed(2)} руб.'),
      ),
      body: ExpenseTable(
        expenses: expenses,
        onRemove: onRemove,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: onAddExpense,
        child: const Icon(Icons.add),
      ),
    );
  }
}
