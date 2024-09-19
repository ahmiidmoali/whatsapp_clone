import 'package:whatsapp_clone/features/chat/domain/entities/chat_entity.dart';
import 'package:whatsapp_clone/features/chat/domain/repository/chat_repository.dart';

class DeleteChatUsecase {
  final ChatRepository chatRepository;

  DeleteChatUsecase({required this.chatRepository});
  Future<void> call(ChatEntity chat) async {
    return await chatRepository.deleteChat(chat);
  }
}
