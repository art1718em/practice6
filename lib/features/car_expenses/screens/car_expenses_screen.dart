import 'package:flutter/material.dart';
import '../models/expense_model.dart';
import '../widgets/expense_table.dart';
import 'package:cached_network_image/cached_network_image.dart';

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
        centerTitle: true,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CachedNetworkImage(
              imageUrl: "https://cdn-icons-png.flaticon.com/512/2921/2921222.png",
              width: 30,
              height: 30,
              placeholder: (context, url) => const CircularProgressIndicator(),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
            const SizedBox(width: 8),
            Text('Расходы: ${totalAmount.toStringAsFixed(2)} руб.'),
          ],
        ),
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
