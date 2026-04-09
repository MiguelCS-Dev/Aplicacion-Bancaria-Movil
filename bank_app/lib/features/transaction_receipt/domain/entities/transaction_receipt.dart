class TransactionReceipt {
  final String id;
  final String type;
  final String description;
  final String category;
  final double amount;
  final DateTime? date;
  final String? note;
  final String? recipient;
  final String? sender;

  TransactionReceipt({
    required this.id,
    required this.type,
    required this.description,
    required this.category,
    required this.amount,
    this.date,
    this.note,
    this.recipient,
    this.sender,
  });
}
