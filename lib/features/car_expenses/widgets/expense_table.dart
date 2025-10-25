import 'package:flutter/material.dart';
import '../models/expense_model.dart';
import 'expense_row.dart';

class ExpenseTable extends StatelessWidget {
  final List<ExpenseModel> expenses;
  final ValueChanged<String>? onRemove;

  const ExpenseTable({
    super.key,
    required this.expenses,
    this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    if (expenses.isEmpty) {
      return const Center(
        child: Text(
          'Расходов пока нет',
          style: TextStyle(fontSize: 18, color: Colors.grey),
        ),
      );
    }

    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (context, index) {
        final expense = expenses[index];
        return ExpenseRow(
          key: ValueKey(expense.id),
          expense: expense,
          onRemove: onRemove != null ? () => onRemove!(expense.id) : null,
        );
      },
    );
  }
}

