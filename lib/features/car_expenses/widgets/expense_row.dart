import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/expense_model.dart';

class ExpenseRow extends StatelessWidget {
  final ExpenseModel expense;
  final VoidCallback? onRemove;

  const ExpenseRow({
    super.key,
    required this.expense,
    this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    final formattedDate = DateFormat('dd.MM.yyyy HH:mm').format(expense.date);

    return ListTile(
      title: Text(expense.title),
      subtitle: Text(formattedDate),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '${expense.amount.toStringAsFixed(2)} руб.',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          if (onRemove != null)
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: onRemove,
            ),
        ],
      ),
    );
  }
}
