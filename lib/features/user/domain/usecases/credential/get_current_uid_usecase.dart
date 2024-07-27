import 'package:whatsapp_clone/features/user/domain/repository/user_repository.dart';

class GetCurrentUIDUseCase {
  final UserRepository repository;
  GetCurrentUIDUseCase({
    required this.repository,
  });
  Future<String> call() async {
    return repository.getCurrentUID();
  }
}
