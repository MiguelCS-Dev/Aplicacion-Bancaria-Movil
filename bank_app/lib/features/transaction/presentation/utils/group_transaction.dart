import '../../domain/entities/transaction.dart';

Map<String, List<Transactio>> groupTransactionsByDate(
  List<Transactio> transactions,
) {
  final Map<String, List<Transactio>> grouped = {};

  for (var tx in transactions) {
    final date = tx.date;

    if (date == null) continue;

    final label = _getDateLabel(date);

    if (!grouped.containsKey(label)) {
      grouped[label] = [];
    }

    grouped[label]!.add(tx);
  }

  return grouped;
}

String _getDateLabel(DateTime date) {
  final now = DateTime.now();

  final today = DateTime(now.year, now.month, now.day);
  final yesterday = today.subtract(const Duration(days: 1));

  final txDate = DateTime(date.year, date.month, date.day);

  if (txDate == today) return 'Today';
  if (txDate == yesterday) return 'Yesterday';

  return '${date.day}/${date.month}/${date.year}';
}
