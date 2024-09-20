import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:whatsapp_clone/features/chat/domain/entities/chat_entity.dart';
import 'package:whatsapp_clone/features/chat/domain/usercases/delete_chat_usecase.dart';
import 'package:whatsapp_clone/features/chat/domain/usercases/get_my_chat_usecase.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  final GetMyChatUsecase getMyChatUsecase;
  final DeleteChatUsecase deleteChatUsecase;

  ChatCubit({required this.getMyChatUsecase, required this.deleteChatUsecase})
      : super(ChatInitial());

  Future<void> getMyChat({required ChatEntity chat}) async {
    try {
      final streamResponse = getMyChatUsecase.call(chat);
      streamResponse.listen(
        (chatContacts) {
          emit(ChatLoaded(chatContacts: chatContacts));
        },
      );
    } on SocketException {
      emit(ChatFailure());
    } catch (_) {
      emit(ChatFailure());
    }
  }

  Future<void> deleteChat({required ChatEntity chat}) async {
    try {
      await deleteChatUsecase.call(chat);
    } on SocketException {
      emit(ChatFailure());
    } catch (e) {
      emit(ChatFailure());
    }
  }
}
