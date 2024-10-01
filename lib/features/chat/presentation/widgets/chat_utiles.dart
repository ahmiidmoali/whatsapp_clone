import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsapp_clone/features/chat/domain/entities/chat_entity.dart';
import 'package:whatsapp_clone/features/chat/domain/entities/message_entity.dart';
import 'package:whatsapp_clone/features/chat/presentation/cubit/message/message_cubit.dart';

class ChatUtiles {
  static Future<void> sendMessage(BuildContext context,
      {required MessageEntity messageEntity,
      String? message,
      String? type,
      String? repliedMessage,
      String? repliedMessageType,
      String? repliedTo}) async {
    BlocProvider.of<MessageCubit>(context).sendMessage(
        chat: ChatEntity(
            createdAt: Timestamp.now(),
            senderName: messageEntity.senderName,
            senderProfile: messageEntity.senderProfile,
            senderUid: messageEntity.senderUid,
            recipientName: messageEntity.recipientName,
            recipientUid: messageEntity.recipientUid,
            recipientProfile: messageEntity.recipientProfile,
            totalUnReadMessages: 0),
        message: MessageEntity(
            createdAt: Timestamp.now(),
            isSeen: false,
            recipientUid: messageEntity.recipientUid,
            recipientName: messageEntity.recipientName,
            senderUid: messageEntity.senderUid,
            senderName: messageEntity.senderName,
            messageType: type,
            message: message,
            repliedMessage: repliedMessage ?? "",
            repliedMessageType: repliedMessageType ?? "",
            repliedTo: repliedTo ?? ""));
  }
}
