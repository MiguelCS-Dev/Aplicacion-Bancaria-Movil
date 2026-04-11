import 'package:bank_app/core/themes/app_colors.dart';
import 'package:bank_app/features/profile/domain/entities/user.dart';
import 'package:bank_app/features/profile/presentation/bloc/profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditProfileForm extends StatefulWidget {
  final AppUser user;

  const EditProfileForm({super.key, required this.user});

  @override
  State<EditProfileForm> createState() => EditProfileFormState();
}

class EditProfileFormState extends State<EditProfileForm> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController emailController;
  late TextEditingController phoneController;

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController(text: widget.user.email);
    phoneController = TextEditingController(text: widget.user.phone);
  }

  @override
  void dispose() {
    emailController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            _buildTextField(
              controller: emailController,
              label: "Email",
              icon: Icons.email_outlined,
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "Ingrese su correo";
                }

                final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

                if (!emailRegex.hasMatch(value)) {
                  return "Correo inválido";
                }

                return null;
              },
            ),

            const SizedBox(height: 16),

            _buildTextField(
              controller: phoneController,
              label: "Teléfono",
              icon: Icons.phone_outlined,
              keyboardType: TextInputType.phone,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(15),
              ],
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Ingrese su número de teléfono';
                }

                if (value.length < 7) {
                  return 'Número demasiado corto';
                }

                if (value.length > 15) {
                  return 'Máximo 15 dígitos';
                }

                return null;
              },
            ),
            const SizedBox(height: 30),
            _buildSubmitButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    List<TextInputFormatter>? inputFormatters,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: primary),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: primary, width: 2),
        ),
        filled: true,
        fillColor: Colors.grey[50],
      ),
    );
  }

  Widget _buildSubmitButton() {
    return Container(
      height: 55,
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [primary, secondary]),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: primary.withValues(alpha: 0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            context.read<ProfileCubit>().updateProfile(
              email: emailController.text.trim(),
              phone: phoneController.text.trim(),
            );
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
        ),
        child: isLoading
            ? const CircularProgressIndicator(color: Colors.white)
            : const Text(
                "Save changes",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
      ),
    );
  }
}
