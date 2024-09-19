import 'package:whatsapp_clone/features/chat/domain/entities/chat_entity.dart';
import 'package:whatsapp_clone/features/chat/domain/entities/message_entity.dart';
import 'package:whatsapp_clone/features/chat/domain/repository/chat_repository.dart';

class SendMessageUsecase {
  final ChatRepository chatRepository;

  SendMessageUsecase({required this.chatRepository});
  Future<void> call(ChatEntity chat, MessageEntity message) async {
    return await chatRepository.sendMessage(chat, message);
  }
}
