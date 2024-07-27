import 'package:whatsapp_clone/features/user/domain/entities/user_entitiy.dart';
import 'package:whatsapp_clone/features/user/domain/repository/user_repository.dart';

class UpdateUserUseCase {
  final UserRepository repository;
  UpdateUserUseCase({
    required this.repository,
  });
  Future<void> call(UserEntity user) async {
    await repository.updateUser(user);
  }
}
