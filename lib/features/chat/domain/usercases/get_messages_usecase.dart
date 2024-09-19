import 'package:whatsapp_clone/features/chat/domain/entities/message_entity.dart';
import 'package:whatsapp_clone/features/chat/domain/repository/chat_repository.dart';

class GetMessagesUsecase {
  final ChatRepository chatRepository;

  GetMessagesUsecase({required this.chatRepository});
  Stream<List<MessageEntity>> call(MessageEntity message) {
    return chatRepository.getMessages(message);
  }
}
