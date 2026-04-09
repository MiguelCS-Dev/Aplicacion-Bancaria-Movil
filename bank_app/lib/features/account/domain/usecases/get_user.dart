import 'package:bank_app/features/account/domain/entities/user_entity.dart';
import 'package:bank_app/features/account/domain/repositories/user_repository.dart';

class GetUserData {
  final UserRepository repository;

  GetUserData(this.repository);

  Future<UserEntity?> call() async {
    return await repository.getCurrentUser();
  }
}
