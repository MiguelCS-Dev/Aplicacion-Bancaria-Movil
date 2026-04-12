class Transfer {
  final String toAccount;
  final double amount;
  final String? note;

  const Transfer({required this.toAccount, required this.amount, this.note});
}
