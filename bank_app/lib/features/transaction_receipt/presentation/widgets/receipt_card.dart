import 'package:bank_app/core/themes/app_colors.dart';
import 'package:flutter/material.dart';
import '../../domain/entities/transaction_receipt.dart';
import 'package:intl/intl.dart';

class ReceiptCard extends StatelessWidget {
  final TransactionReceipt receipt;

  const ReceiptCard({super.key, required this.receipt});

  @override
  Widget build(BuildContext context) {
    final isDebit = receipt.type == 'debit';
    final statusColor = const Color(0xFF4CAF50);
    final amountText = '\$${receipt.amount.toStringAsFixed(2)}';

    String formattedDate = 'Unknown date';
    if (receipt.date != null) {
      formattedDate = DateFormat(
        'MMM dd, yyyy • hh:mm a',
      ).format(receipt.date!);
    }

    return Center(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        constraints: const BoxConstraints(maxWidth: 500),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 16,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          children: [
            // HEADER
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: statusColor,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(16),
                ),
              ),
              child: Column(
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.check_circle,
                      color: Colors.white,
                      size: 50,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    isDebit ? 'Payment Sent' : 'Payment Received',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    amountText,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            // STATUS BADGE
            Padding(padding: const EdgeInsets.all(16), child: _statusBadge()),

            _divider(),

            // DETAILS
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  _detailRow(
                    'Reference',
                    receipt.id.length > 12
                        ? '${receipt.id.substring(0, 12)}...'
                        : receipt.id,
                    highlight: true,
                  ),
                  _detailRow(
                    'Transaction Type',
                    isDebit ? 'Payment Sent' : 'Payment Received',
                  ),
                  _detailRow('Category', receipt.category),

                  if (receipt.recipient != null)
                    _detailRow('Recipient', receipt.recipient!),

                  if (receipt.sender != null)
                    _detailRow('Sender', receipt.sender!),

                  _detailRow('Description', receipt.description),

                  if (receipt.note != null && receipt.note!.isNotEmpty)
                    _detailRow('Note', receipt.note!),

                  _detailRow('Date', formattedDate),
                ],
              ),
            ),

            _divider(),

            // AMOUNT DETAILS
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Amount Details',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 16),
                  _amountRow('Amount', amountText),
                  _amountRow('Service Fee', '\$0.00'),
                  const Divider(),
                  _amountRow('Total Amount', amountText, isTotal: true),
                ],
              ),
            ),

            // FOOTER
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: const BorderRadius.vertical(
                  bottom: Radius.circular(16),
                ),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.info_outline,
                        size: 16,
                        color: Colors.grey[600],
                      ),
                      const SizedBox(width: 8),
                      const Expanded(
                        child: Text(
                          'Keep this receipt for your records',
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Need help? support@edbank.com',
                    style: TextStyle(fontSize: 11, color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _divider() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Divider(color: Colors.grey[300]),
    );
  }

  Widget _detailRow(String label, String value, {bool highlight = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Text(label, style: TextStyle(color: Colors.grey[600])),
          const Spacer(),
          Expanded(
            flex: 2,
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: TextStyle(
                color: highlight ? primary : Colors.black87,
                fontWeight: highlight ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _amountRow(String label, String value, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Text(
            value,
            style: TextStyle(
              fontWeight: isTotal ? FontWeight.bold : FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _statusBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFE8F5E9),
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.check_circle, size: 18, color: Color(0xFF2E7D32)),
          SizedBox(width: 6),
          Text(
            'Completed',
            style: TextStyle(
              color: Color(0xFF2E7D32),
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
