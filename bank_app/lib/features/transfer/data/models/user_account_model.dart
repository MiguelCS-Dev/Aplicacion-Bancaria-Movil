import '../../domain/entities/user_account.dart';

class UserAccountModel extends UserAccount {
  const UserAccountModel({
    required super.accountNumber,
    required super.name,
    required super.phone,
  });

  factory UserAccountModel.fromJson(Map<String, dynamic> json) {
    return UserAccountModel(
      accountNumber: json['account_number'].toString(),
      name: json['name'] ?? '',
      phone: json['phone'].toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {'account_number': accountNumber, 'name': name, 'phone': phone};
  }
}
