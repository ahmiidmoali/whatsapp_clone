part of 'chat_rebuild_cubit.dart';

class ChatRebuildState extends Equatable {
  final bool isShowAttachWindow;
  final bool isDisplaySendButton;
  final bool isShowEmojiKeyboard;

  const ChatRebuildState(
      {required this.isShowAttachWindow,
      required this.isDisplaySendButton,
      required this.isShowEmojiKeyboard});
  ChatRebuildState copyWith({
    bool? isShowAttachWindow,
    bool? isDisplaySendButton,
    bool? isShowEmojiKeyboard,
  }) {
    return ChatRebuildState(
        isDisplaySendButton: isDisplaySendButton ?? this.isDisplaySendButton,
        isShowAttachWindow: isShowAttachWindow ?? this.isShowAttachWindow,
        isShowEmojiKeyboard: isShowEmojiKeyboard ?? this.isShowEmojiKeyboard);
  }

  @override
  List<Object> get props =>
      [isShowAttachWindow, isDisplaySendButton, isShowEmojiKeyboard];
}
