import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:whatsapp_clone/features/chat/domain/entities/chat_entity.dart';
import 'package:whatsapp_clone/features/chat/domain/entities/message_entity.dart';
import 'package:whatsapp_clone/features/chat/domain/usercases/delete_message_usecase.dart';
import 'package:whatsapp_clone/features/chat/domain/usercases/get_messages_usecase.dart';
import 'package:whatsapp_clone/features/chat/domain/usercases/send_message_usecase.dart';

part 'message_state.dart';

class MessageCubit extends Cubit<MessageState> {
  final GetMessagesUsecase getMessagesUsecase;
  final SendMessageUsecase sendMessageUsecase;
  final DeleteMessageUsecase deleteMessageUsecase;
  MessageCubit(
      {required this.getMessagesUsecase,
      required this.sendMessageUsecase,
      required this.deleteMessageUsecase})
      : super(MessageInitial());
  Future<void> getMessages({required MessageEntity message}) async {
    try {
      emit(MessageLoading());
      final streamRequest = getMessagesUsecase.call(message);
      streamRequest.listen(
        (messages) {
          print(" new messaged recieved on cubit${messages.length}");
          emit(MessageLoaded(messages: messages));
        },
      );
    } on Exception {
      emit(MessageFailure());
    } catch (_) {
      emit(MessageFailure());
    }
  }

  Future<void> sendMessage(
      {required ChatEntity chat, required MessageEntity message}) async {
    try {
      await sendMessageUsecase.call(chat, message);
    } on Exception {
      emit(MessageFailure());
    } catch (_) {
      emit(MessageFailure());
    }
  }

  Future<void> deleteMessage({required MessageEntity message}) async {
    try {
      await deleteMessageUsecase.call(message);
    } on Exception {
      emit(MessageFailure());
    } catch (_) {
      emit(MessageFailure());
    }
  }
}
