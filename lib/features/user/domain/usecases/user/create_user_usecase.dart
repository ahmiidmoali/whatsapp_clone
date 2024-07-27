import 'package:whatsapp_clone/features/user/domain/entities/user_entitiy.dart';
import 'package:whatsapp_clone/features/user/domain/repository/user_repository.dart';

class CreateUserUseCase {
  final UserRepository repository;
  CreateUserUseCase({
    required this.repository,
  });
  Future<void> call(UserEntity user) async {
    await repository.createUser(user);
  }
}
