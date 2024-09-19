import 'package:whatsapp_clone/features/chat/domain/entities/message_entity.dart';
import 'package:whatsapp_clone/features/chat/domain/repository/chat_repository.dart';

class DeleteMessageUsecase {
  final ChatRepository chatRepository;

  DeleteMessageUsecase({required this.chatRepository});
  Future<void> call(MessageEntity message) async {
    return await chatRepository.deleteMessage(message);
  }
}
