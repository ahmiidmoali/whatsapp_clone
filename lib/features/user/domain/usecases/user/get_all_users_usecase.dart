import 'package:whatsapp_clone/features/user/domain/entities/user_entitiy.dart';
import 'package:whatsapp_clone/features/user/domain/repository/user_repository.dart';

class GetAllUsersUseCase {
  final UserRepository repository;
  GetAllUsersUseCase({
    required this.repository,
  });
  Stream<List<UserEntity>> call() {
    return repository.getAllUsers();
  }
}
