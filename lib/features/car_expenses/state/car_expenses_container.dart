import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../models/expense_model.dart';
import '../screens/add_expense_screen.dart';
import '../screens/car_expenses_screen.dart';

enum ScreenView { expensesTable, addExpense }

class CarExpensesContainer extends StatefulWidget {
  const CarExpensesContainer({super.key});

  @override
  State<CarExpensesContainer> createState() => _CarExpensesContainerState();
}

class _CarExpensesContainerState extends State<CarExpensesContainer> {
  final List<ExpenseModel> _expenses = [];
  final _uuid = const Uuid();

  ScreenView _currentView = ScreenView.expensesTable;

  ExpenseModel? _recentlyRemovedExpense;
  int? _recentlyRemovedExpenseIndex;

  double get _totalAmount {
    return _expenses.fold(0.0, (sum, item) => sum + item.amount);
  }

  void _saveExpense(String title, double amount) {
    final newExpense = ExpenseModel(
      id: _uuid.v4(),
      title: title,
      amount: amount,
      date: DateTime.now(),
    );
    setState(() {
      _expenses.add(newExpense);
      _currentView = ScreenView.expensesTable;
    });
  }

  void _removeExpense(String id) {
    final expenseIndex = _expenses.indexWhere((expense) => expense.id == id);
    if (expenseIndex < 0) {
      return;
    }

    setState(() {
      _recentlyRemovedExpenseIndex = expenseIndex;
      _recentlyRemovedExpense = _expenses.removeAt(expenseIndex);

      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Расход удален'),
          duration: const Duration(seconds: 3),
          action: SnackBarAction(
            label: 'ОТМЕНИТЬ',
            onPressed: _undoRemove,
          ),
        ),
      );
    });
  }

  void _undoRemove() {
    if (_recentlyRemovedExpense != null && _recentlyRemovedExpenseIndex != null) {
      setState(() {
        _expenses.insert(
            _recentlyRemovedExpenseIndex!, _recentlyRemovedExpense!);
        _recentlyRemovedExpense = null;
        _recentlyRemovedExpenseIndex = null;
      });
    }
  }

  void _showExpensesTable() =>
      setState(() => _currentView = ScreenView.expensesTable);
  void _showAddExpense() => setState(() => _currentView = ScreenView.addExpense);

  @override
  Widget build(BuildContext context) {
    Widget activeScreen;
    if (_currentView == ScreenView.expensesTable) {
      activeScreen = CarExpensesScreen(
        key: const ValueKey('ExpensesTable'),
        expenses: _expenses,
        totalAmount: _totalAmount,
        onAddExpense: _showAddExpense,
        onRemove: _removeExpense,
      );
    } else {
      activeScreen = AddExpenseScreen(
        key: const ValueKey('AddExpense'),
        onSave: _saveExpense,
        onCancel: _showExpensesTable,
      );
    }

    return Scaffold(
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 200),
        child: activeScreen,
      ),
    );
  }
}


