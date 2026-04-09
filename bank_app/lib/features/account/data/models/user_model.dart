import '../../domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({required super.id, required super.name});

  factory UserModel.fromFirestore(String id, Map<String, dynamic> json) {
    return UserModel(id: id, name: json['name'] ?? 'User');
  }
}
