import 'package:bank_app/features/transfer/presentation/bloc/transfer_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TransferNoteField extends StatelessWidget {
  const TransferNoteField({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: const InputDecoration(
        labelText: 'Nota (opcional)',
        hintText: 'Ej: pago de almuerzo, deuda, etc.',
        border: OutlineInputBorder(),
      ),
      onChanged: (value) {
        context.read<TransferCubit>().updateNote(value);
      },
    );
  }
}
