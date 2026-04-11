class Transfer {
  final String fromAccount;
  final String toAccount;
  final double amount;
  final String? note;

  const Transfer({
    required this.fromAccount,
    required this.toAccount,
    required this.amount,
    this.note,
  });
}
