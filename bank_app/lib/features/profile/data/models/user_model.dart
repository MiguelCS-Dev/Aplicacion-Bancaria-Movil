import 'package:bank_app/features/profile/domain/entities/user.dart';

class AppUserModel extends AppUser {
  AppUserModel({
    required String name,
    required String email,
    required String phone,
    required String accountNumber,
    required double balance,
  }) : super(
         name: name,
         email: email,
         phone: phone,
         accountNumber: accountNumber,
         balance: balance,
       );

  factory AppUserModel.fromJson(Map<String, dynamic> json) {
    return AppUserModel(
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      accountNumber: json['account_number'] ?? '',
      balance: (json['account_balance'] ?? 0.0).toDouble(),
    );
  }
}
