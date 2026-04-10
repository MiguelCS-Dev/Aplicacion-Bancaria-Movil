import 'package:bank_app/features/profile/domain/entities/user.dart';

class AppUserModel extends AppUser {
  AppUserModel({
    required String name,
    required String email,
    required String phone,
    required String accountNumber,
  }) : super(
         name: name,
         email: email,
         phone: phone,
         accountNumber: accountNumber,
       );

  factory AppUserModel.fromJson(Map<String, dynamic> json) {
    return AppUserModel(
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      accountNumber: json['account_number'] ?? '',
    );
  }
}
