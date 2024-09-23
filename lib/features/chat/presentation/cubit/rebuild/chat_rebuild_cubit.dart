import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'chat_rebuild_state.dart';

class ChatRebuildCubit extends Cubit<ChatRebuildState> {
  ChatRebuildCubit()
      : super(ChatRebuildState(
            isDisplaySendButton: false,
            isShowAttachWindow: false,
            isShowEmojiKeyboard: false));
  void toggleSendButton(String value) {
    if (value.isNotEmpty) {
      emit(state.copyWith(isDisplaySendButton: true));
    }
    if (value.isEmpty) {
      emit(state.copyWith(isDisplaySendButton: false));
    }
  }

  void toggleShowAttachWindow() {
    emit(state.copyWith(isShowAttachWindow: !state.isShowAttachWindow));
  }

  void toggleShowEmojiKeyboard() {
    emit(state.copyWith(isShowEmojiKeyboard: !state.isShowAttachWindow));
  }
}
