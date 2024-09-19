import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';
import 'package:whatsapp_clone/features/app/const/firebase_collection_const.dart';
import 'package:whatsapp_clone/features/app/const/message_type_const.dart';
import 'package:whatsapp_clone/features/chat/data/data_sources/chat_remote_data_source.dart';
import 'package:whatsapp_clone/features/chat/data/models/chat_model.dart';
import 'package:whatsapp_clone/features/chat/data/models/message_model.dart';
import 'package:whatsapp_clone/features/chat/domain/entities/chat_entity.dart';
import 'package:whatsapp_clone/features/chat/domain/entities/message_entity.dart';

class ChatRemoteDataSourceImp extends ChatRemoteDataSource {
  final FirebaseFirestore firestore;

  ChatRemoteDataSourceImp({required this.firestore});

  @override
  Future<void> sendMessage(ChatEntity chat, MessageEntity message) async {
    await sendMessageBasedOnType(message);
    String recentTextMessage = "";
    switch (message.messageType) {
      case MessageTypeConst.photoMessage:
        recentTextMessage = "📷 Photo";
        break;
      case MessageTypeConst.videoMessage:
        recentTextMessage = "📸 Video";
        break;
      case MessageTypeConst.audioMessage:
        recentTextMessage = "🎵 Audio";
        break;
      case MessageTypeConst.gifMessage:
        recentTextMessage = "GIF";
        break;
      default:
        recentTextMessage = message.message!;
    }
    await addToChat(ChatEntity(
        createdAt: chat.createdAt,
        recentTextMessage: recentTextMessage,
        recipientName: chat.recipientName,
        recipientProfile: chat.recipientProfile,
        recipientUid: chat.recipientUid,
        senderName: chat.senderName,
        senderProfile: chat.senderUid,
        senderUid: chat.senderUid,
        totalUnReadMessages: chat.totalUnReadMessages));
  }

  Future addToChat(ChatEntity chat) async {
    final myChatRef = firestore
        .collection(FirebaseCollectionConst.users)
        .doc(chat.senderUid)
        .collection(FirebaseCollectionConst.myChat);
    final otherChatRef = firestore
        .collection(FirebaseCollectionConst.users)
        .doc(chat.recipientUid)
        .collection(FirebaseCollectionConst.myChat);
    final myNewChat = ChatModel(
            createdAt: chat.createdAt,
            senderUid: chat.senderUid,
            recipientUid: chat.recipientUid,
            recentTextMessage: chat.recentTextMessage,
            senderName: chat.senderName,
            recipientName: chat.recipientName,
            recipientProfile: chat.recipientProfile,
            senderProfile: chat.senderProfile,
            totalUnReadMessages: chat.totalUnReadMessages)
        .toDocument();
    final otherNewChat = ChatModel(
            createdAt: chat.createdAt,
            senderUid: chat.recipientUid,
            senderName: chat.recipientName,
            senderProfile: chat.recipientProfile,
            recipientUid: chat.senderUid,
            recipientName: chat.senderName,
            recipientProfile: chat.senderProfile,
            recentTextMessage: chat.recentTextMessage,
            totalUnReadMessages: chat.totalUnReadMessages)
        .toDocument();
    try {
      myChatRef.doc(chat.recipientUid).get().then(
        (myChatDoc) async {
          if (!myChatDoc.exists) {
            await myChatRef.doc(chat.recipientUid).set(myNewChat);
            await myChatRef.doc(chat.senderUid).set(otherNewChat);
            return;
          } else {
            await myChatRef.doc(chat.recipientUid).update(myNewChat);
            await otherChatRef.doc(chat.senderUid).update(otherNewChat);
            return;
          }
        },
      );
    } catch (e) {
      print("error with creating the chat $e");
    }
  }

  Future sendMessageBasedOnType(MessageEntity message) async {
    final myMessageRef = firestore
        .collection(FirebaseCollectionConst.users)
        .doc(message.senderUid)
        .collection(FirebaseCollectionConst.myChat)
        .doc(message.recipientUid)
        .collection(FirebaseCollectionConst.messages);
    final otherMessageRef = firestore
        .collection(FirebaseCollectionConst.users)
        .doc(message.recipientUid)
        .collection(FirebaseCollectionConst.myChat)
        .doc(message.senderUid)
        .collection(FirebaseCollectionConst.messages);
    String messageUid = const Uuid().v1();
    final myNewMessage = MessageModel(
            createdAt: message.createdAt,
            isSeen: message.isSeen,
            message: message.message,
            messageId: messageUid,
            messageType: message.messageType,
            recipientName: message.recipientName,
            recipientUid: message.recipientUid,
            repliedMessage: message.repliedMessage,
            repliedMessageType: message.repliedMessageType,
            repliedTo: message.repliedTo,
            senderName: message.senderName,
            senderUid: message.senderUid)
        .toDocument();
    try {
      await myMessageRef.doc(messageUid).set(myNewMessage);
      await otherMessageRef.doc(messageUid).set(myNewMessage);
    } catch (e) {
      print("error with sending the message $e");
    }
  }

  @override
  Future<void> deleteChat(ChatEntity chat) async {
    final myChatRef = firestore
        .collection(FirebaseCollectionConst.users)
        .doc(chat.senderUid)
        .collection(FirebaseCollectionConst.myChat);
    try {
      await myChatRef.doc(chat.recipientUid).delete();
    } catch (e) {
      print("error while deleting this chat${e}");
    }
  }

  @override
  Future<void> deleteMessage(MessageEntity message) async {
    final myMessageRef = firestore
        .collection(FirebaseCollectionConst.users)
        .doc(message.senderUid)
        .collection(FirebaseCollectionConst.myChat)
        .doc(message.recipientUid)
        .collection(FirebaseCollectionConst.messages);
    try {
      await myMessageRef.doc(message.messageId).delete();
    } catch (e) {
      print("error while deleting this message ${e}");
    }
  }

  @override
  Stream<List<MessageEntity>> getMessages(MessageEntity message) {
    final myMessageRef = firestore
        .collection(FirebaseCollectionConst.users)
        .doc(message.senderUid)
        .collection(FirebaseCollectionConst.myChat)
        .doc(message.recipientUid)
        .collection(FirebaseCollectionConst.messages)
        .orderBy("createdAt", descending: false);
    return myMessageRef.snapshots().map((querySnapshots) =>
        querySnapshots.docs.map((e) => MessageModel.fromSnapshot(e)).toList());
  }

  @override
  Stream<List<ChatEntity>> getMyChat(ChatEntity chat) {
    final myChatRef = firestore
        .collection(FirebaseCollectionConst.users)
        .doc(chat.senderUid)
        .collection(FirebaseCollectionConst.myChat)
        .orderBy("createdAt", descending: true);
    return myChatRef.snapshots().map((querySnapshots) =>
        querySnapshots.docs.map((e) => ChatModel.fromSnapshot(e)).toList());
  }
}
