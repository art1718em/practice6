class ExpenseModel {
  final String id;
  final String title;
  final double amount;
  final DateTime date;

  ExpenseModel({
    required this.id,
    required this.title,
    required this.amount,
    required this.date,
  });

  ExpenseModel copyWith({
    String? id,
    String? title,
    double? amount,
    DateTime? date,
  }) {
    return ExpenseModel(
      id: id ?? this.id,
      title: title ?? this.title,
      amount: amount ?? this.amount,
      date: date ?? this.date,
    );
  }
}
