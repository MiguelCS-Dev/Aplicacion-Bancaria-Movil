class AccountSummaryEntity {
  final double income;
  final double expenses;
  final int transactions;

  AccountSummaryEntity({
    required this.income,
    required this.expenses,
    required this.transactions,
  });

  double get balance => income - expenses;
}
