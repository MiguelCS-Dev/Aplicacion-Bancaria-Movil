import '../../domain/entities/user_account.dart';

class UserAccountModel extends UserAccount {
  const UserAccountModel({
    required super.accountNumber,
    required super.name,
    required super.phone,
    required super.balance,
  });

  factory UserAccountModel.fromJson(Map<String, dynamic> json) {
    return UserAccountModel(
      accountNumber: json['account_number'].toString(),
      name: json['name'] ?? '',
      phone: json['phone'].toString(),
      balance: (json['account_balance'] ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {'account_number': accountNumber, 'name': name, 'phone': phone};
  }
}
