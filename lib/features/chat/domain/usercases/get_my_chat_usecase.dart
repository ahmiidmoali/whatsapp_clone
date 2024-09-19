import 'package:whatsapp_clone/features/chat/domain/entities/chat_entity.dart';

import 'package:whatsapp_clone/features/chat/domain/repository/chat_repository.dart';

class GetMyChatUsecase {
  final ChatRepository chatRepository;

  GetMyChatUsecase({required this.chatRepository});
  Stream<List<ChatEntity>> call(ChatEntity chat) {
    return chatRepository.getMyChat(chat);
  }
}
