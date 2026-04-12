import 'package:bank_app/core/themes/inputs_decoration.dart';
import 'package:bank_app/features/transfer/presentation/bloc/transfer_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NoteInput extends StatelessWidget {
  const NoteInput({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLines: 2,
      maxLength: 20,
      decoration: buildInputDecoration(
        label: "Note (optional)",
        icon: Icons.note_alt_outlined,
      ),
      onChanged: (value) {
        context.read<TransferCubit>().updateNote(value);
      },
    );
  }
}
