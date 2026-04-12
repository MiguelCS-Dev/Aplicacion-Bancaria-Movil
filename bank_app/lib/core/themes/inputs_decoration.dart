import 'package:flutter/material.dart';
import 'app_colors.dart';

InputDecoration buildInputDecoration({
  required String label,
  required IconData icon,
}) {
  return InputDecoration(
    labelText: label,
    prefixIcon: Icon(icon, color: primary),

    filled: true,
    fillColor: Colors.grey[50],

    // BORDE NORMAL
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: Colors.grey.shade400, width: 1.5),
    ),

    // BORDE FOCUSED
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: secondary, width: 2.2),
    ),

    // ERROR
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: Colors.red, width: 1.5),
    ),

    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: Colors.red, width: 2),
    ),

    // LABEL
    labelStyle: TextStyle(
      color: Colors.grey.shade700,
      fontWeight: FontWeight.w500,
    ),
  );
}
