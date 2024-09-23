import 'package:whatsapp_clone/features/chat/data/data_sources/chat_remote_data_source.dart';
import 'package:whatsapp_clone/features/chat/domain/entities/chat_entity.dart';
import 'package:whatsapp_clone/features/chat/domain/entities/message_entity.dart';
import 'package:whatsapp_clone/features/chat/domain/repository/chat_repository.dart';

class ChatRepositoryImp extends ChatRepository {
  ChatRemoteDataSource chatRemoteDataSource;
  ChatRepositoryImp({
    required this.chatRemoteDataSource,
  });

  @override
  Future<void> deleteChat(ChatEntity chat) =>
      chatRemoteDataSource.deleteChat(chat);

  @override
  Future<void> deleteMessage(MessageEntity message) =>
      chatRemoteDataSource.deleteMessage(message);

  @override
  Stream<List<MessageEntity>> getMessages(MessageEntity message) =>
      chatRemoteDataSource.getMessages(message);

  @override
  Stream<List<ChatEntity>> getMyChat(ChatEntity chat) =>
      chatRemoteDataSource.getMyChat(chat);

  @override
  Future<void> sendMessage(ChatEntity chat, MessageEntity message) =>
      chatRemoteDataSource.sendMessage(chat, message);
}
