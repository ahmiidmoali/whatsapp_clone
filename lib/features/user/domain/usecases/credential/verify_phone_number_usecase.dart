import 'package:whatsapp_clone/features/user/domain/repository/user_repository.dart';

class VerifyPhoneNumberUseCase {
  final UserRepository repository;
  VerifyPhoneNumberUseCase({
    required this.repository,
  });
  Future<void> call(String phoneNumber) async {
    await repository.verifyPhoneNumber(phoneNumber);
  }
}
