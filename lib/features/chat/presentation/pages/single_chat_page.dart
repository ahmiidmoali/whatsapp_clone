import 'dart:io';

import 'package:agora_uikit/agora_uikit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:whatsapp_clone/features/app/const/app_const.dart';
import 'package:whatsapp_clone/features/app/const/message_type_const.dart';
import 'package:whatsapp_clone/features/app/global/widgets/show_image_picked_widget.dart';
import 'package:whatsapp_clone/features/app/global/widgets/show_video_picked_widget.dart';
import 'package:whatsapp_clone/features/app/theme/style.dart';
import 'package:whatsapp_clone/features/chat/domain/entities/chat_entity.dart';
import 'package:whatsapp_clone/features/chat/domain/entities/message_entity.dart';
import 'package:whatsapp_clone/features/chat/presentation/cubit/message/message_cubit.dart';
import 'package:whatsapp_clone/features/chat/presentation/cubit/rebuild/chat_rebuild_cubit.dart';
import 'package:whatsapp_clone/features/chat/presentation/widgets/chat_attached_widget.dart';
import 'package:whatsapp_clone/features/chat/presentation/widgets/chat_message_layout.dart';
import 'package:whatsapp_clone/features/chat/presentation/widgets/chat_textfield_widget.dart';
import 'package:whatsapp_clone/features/chat/presentation/widgets/chat_utiles.dart';
import 'package:whatsapp_clone/storage/storage_provider.dart';

class SingleChatPage extends StatefulWidget {
  final MessageEntity message;
  const SingleChatPage({super.key, required this.message});

  @override
  State<SingleChatPage> createState() => _SingleChatPageState();
}

class _SingleChatPageState extends State<SingleChatPage> {
  final ScrollController _scrollController = ScrollController();
  late TextEditingController messageController;
  bool _isVisible = false;
  bool _isDisplaySendButton = false;

  // FlutterSoundRecorder? _soundRecorder;
  // bool _isRecording = false;
  // bool _isRecordInit = false;
  File? _image;
  Future selectImage() async {
    try {
      final pickedFile =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      setState(() {
        if (pickedFile != null) {
          _image = File(pickedFile.path);
        } else {
          print("no image");
        }
      });
    } catch (e) {
      toast("some $e");
    }
  }

  File? _video;
  Future selectVideo() async {
    try {
      final pickedFile =
          await ImagePicker().pickVideo(source: ImageSource.gallery);
      setState(() {
        if (pickedFile != null) {
          _video = File(pickedFile.path);
        } else {
          print("no vedio");
        }
      });
    } catch (e) {
      toast("some $e");
    }
  }

  @override
  void initState() {
    // _soundRecorder = FlutterSoundRecorder();
    // _openAudioRecording();
    messageController = TextEditingController();
    BlocProvider.of<MessageCubit>(context).getMessages(
        message: MessageEntity(
            senderUid: widget.message.senderUid,
            recipientUid: widget.message.recipientUid));
    super.initState();
  }

  Future<void> _scrollToBottom() async {
    if (_scrollController.hasClients) {
      await Future.delayed(const Duration(milliseconds: 100));
      _scrollController.animateTo(_scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
    }
  }
  // Future<void> _openAudioRecording() async {
  //   final status = await Permission.microphone.request();
  //   if (status != PermissionStatus.granted) {
  //     throw RecordingPermissionException('Mic permission not allowed!');
  //   }
  //   await _soundRecorder!.openRecorder();
  //   _isRecordInit = true;
  // }

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        _scrollToBottom();
      },
    );
    return Scaffold(
        appBar: AppBar(
          title: ListTile(
            title: Text(
              "${widget.message.recipientName}",
              style: const TextStyle(
                  color: whiteColor, fontSize: 16, fontWeight: FontWeight.w500),
            ),
            subtitle: const Text(
              "            Online",
              style: TextStyle(
                color: whiteColor,
                fontSize: 12,
              ),
            ),
          ),
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(
                Icons.arrow_back,
                color: greyColor,
              )),
          // ignore: prefer_const_literals_to_create_immutables
          actions: [
            const Icon(Icons.videocam_rounded),
            const SizedBox(
              width: 20,
            ),
            const Icon(
              Icons.call,
              color: greyColor,
            ),
            const SizedBox(
              width: 10,
            ),
            const Icon(
              Icons.more_vert,
              color: greyColor,
            ),
          ],
        ),
        body: BlocBuilder<MessageCubit, MessageState>(
          builder: (context, state) {
            if (state is MessageLoaded) {
              WidgetsBinding.instance.addPostFrameCallback(
                (timeStamp) {
                  _scrollToBottom();
                },
              );
              final messages = state.messages;
              print(
                  " new messaged recieved on single chat ${(messages.length)}");
              return Padding(
                padding: EdgeInsets.all(2)
                    .copyWith(bottom: MediaQuery.of(context).viewInsets.bottom),
                child: Stack(
                  children: [
                    Positioned(
                      left: 0,
                      right: 0,
                      top: 0,
                      bottom: 0,
                      child: GestureDetector(
                          onTap: () {
                            if (_isVisible) {
                              BlocProvider.of<ChatRebuildCubit>(context)
                                  .toggleShowAttachWindow();
                            }
                          },
                          child: Image.asset(
                            "assets/whatsapp_bg_image.png",
                            fit: BoxFit.cover,
                          )),
                    ),
                    Column(
                      children: [
                        Expanded(
                            child: GestureDetector(
                          onTap: () {
                            if (_isVisible) {
                              BlocProvider.of<ChatRebuildCubit>(context)
                                  .toggleShowAttachWindow();
                            }
                          },
                          child: ListView.builder(
                            controller: _scrollController,
                            itemCount: messages.length,
                            itemBuilder: (context, index) {
                              final message = messages[index];
                              if (message.senderUid ==
                                  widget.message.senderUid) {
                                return MessageLayout(
                                  messageType: message.messageType,
                                  messageBgColor: messageColor,
                                  alignment: Alignment.centerRight,
                                  createAt: Timestamp.now(),
                                  onSwipe: () {},
                                  message: message.message!,
                                  isShowTick: true,
                                  isSeen: true,
                                  onLongPress: () {},
                                );
                              } else {
                                return MessageLayout(
                                  messageType: message.messageType,
                                  messageBgColor: senderMessageColor,
                                  alignment: Alignment.centerLeft,
                                  createAt: Timestamp.now(),
                                  onSwipe: () {},
                                  message: message.message!,
                                  isShowTick: true,
                                  isSeen: true,
                                  onLongPress: () {},
                                );
                              }
                            },
                          ),
                        )),
                        // -------AttachedWidget------------------------
                        BlocBuilder<ChatRebuildCubit, ChatRebuildState>(
                          builder: (context, state) {
                            if (state.isShowAttachWindow) {
                              _isVisible = true;
                              // WidgetsBinding.instance.addPostFrameCallback(
                              //   (timeStamp) {
                              //     _scrollToBottom();
                              //   },
                              // );
                              return AttachedWidget(
                                selectGif: () {
                                  _sendGifMessage();
                                },
                                selectVedio: () {
                                  selectVideo().then(
                                    (value) {
                                      if (_video != null) {
                                        WidgetsBinding.instance
                                            .addPostFrameCallback(
                                          (timeStamp) {
                                            showVideoPickedBottomModalSheet(
                                              context,
                                              file: _video,
                                              recipientName:
                                                  widget.message.recipientName,
                                              onTap: () {
                                                _sendVideoMessage();
                                                Navigator.of(context).pop();
                                              },
                                            );
                                          },
                                        );
                                        BlocProvider.of<ChatRebuildCubit>(
                                                context)
                                            .toggleShowAttachWindow();
                                      }
                                    },
                                  );
                                },
                              );
                            } else {
                              _isVisible = false;
                              return const SizedBox(
                                height: 0,
                              );
                            }
                          },
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // ChatTextfieldWidget--------------------------------------
                            Expanded(
                                child: ChatTextfieldWidget(
                              selectImage: () {
                                selectImage().then(
                                  (value) {
                                    if (_image != null) {
                                      WidgetsBinding.instance
                                          .addPostFrameCallback(
                                        (timeStamp) {
                                          showImagePickedBottomModalSheet(
                                            context,
                                            file: _image,
                                            recipientName:
                                                widget.message.recipientName,
                                            onTap: () {
                                              _sendImageMessage();
                                              Navigator.of(context).pop();
                                            },
                                          );
                                        },
                                      );
                                    }
                                  },
                                );
                              },
                              onChanged: (value) {
                                if (value.isNotEmpty) {
                                  BlocProvider.of<ChatRebuildCubit>(context)
                                      .toggleSendButton(value);
                                } else {
                                  BlocProvider.of<ChatRebuildCubit>(context)
                                      .toggleSendButton(value);
                                }
                              },
                              controller: messageController,
                              onClickAttached: () {
                                BlocProvider.of<ChatRebuildCubit>(context)
                                    .toggleShowAttachWindow();
                              },
                            )),
                            // send &record button--------------------------------------
                            BlocBuilder<ChatRebuildCubit, ChatRebuildState>(
                              builder: (context, state) {
                                _isDisplaySendButton =
                                    state.isDisplaySendButton;
                                return Container(
                                  margin:
                                      const EdgeInsets.symmetric(horizontal: 3),
                                  decoration: const BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(40)),
                                      color: tabColor),
                                  child: IconButton(
                                      onPressed: () {
                                        _sendTextMessage();
                                      },
                                      icon: Icon(
                                        _isDisplaySendButton
                                            ? Icons.send
                                            // : _isRecording
                                            //     ? Icons.close
                                            : Icons.mic,
                                        color: whiteColor,
                                        size: 30,
                                      )),
                                );
                              },
                            )
                          ],
                        ),
                      ],
                    ),
                    // BlocBuilder<ChatRebuildCubit, ChatRebuildState>(
                    //   builder: (context, state) {
                    //     if (state.isShowAttachWindow) {
                    //       _isVisible = true;
                    //       WidgetsBinding.instance.addPostFrameCallback(
                    //         (timeStamp) {
                    //           _scrollToBottom();
                    //         },
                    //       );
                    //       return Positioned(
                    //           right: 1,
                    //           top: 350,
                    //           left: 50,
                    //           child: AttachedWidget());
                    //     } else {
                    //       _isVisible = false;
                    //       return const SizedBox(
                    //         height: 0,
                    //       );
                    //     }
                    //   },
                    // )
                  ],
                ),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(
                  color: tabColor,
                ),
              );
            }
          },
        ));
  }

  void _sendTextMessage() async {
    _sendMessage(
        message: messageController.text, type: MessageTypeConst.textMessage);
  }
//     //TODO : ----recording ---

  // void _sendTextMessage() async {
  //   if (_isDisplaySendButton) {
  //     _sendMessage(
  //         message: messageController.text, type: MessageTypeConst.textMessage);
  //   } else {
  //     final temporaryDir = await getTemporaryDirectory();
  //     final audioPath = "${temporaryDir.path}/flutter_sound.aac";
  //     if (!_isRecordInit) {
  //       return;
  //     }
  //     if (_isRecording == true) {
  //       await _soundRecorder!.stopRecorder();
  //       StorageProviderRemoteDataSource.uploadMessageFile(
  //               file: File(audioPath),
  //               onComplete: (isUploading) {},
  //               uid: widget.message.senderUid,
  //               otherUid: widget.message.recipientUid,
  //               type: MessageTypeConst.audioMessage)
  //           .then(
  //         (audioUrl) {
  //           _sendMessage(
  //               message: audioUrl, type: MessageTypeConst.audioMessage);
  //         },
  //       );
  //     } else {
  //       await _soundRecorder!.startRecorder(toFile: audioPath);
  //     }
  //     //TODO :
  //     setState(() {
  //       _isRecording = !_isRecording;
  //     });
  //   }
  // }

  void _sendImageMessage() {
    StorageProviderRemoteDataSource.uploadMessageFile(
            file: _image!,
            onComplete: (isUploading) {},
            uid: widget.message.senderUid,
            otherUid: widget.message.recipientUid,
            type: MessageTypeConst.photoMessage)
        .then(
      (photoImageUrl) => _sendMessage(
          message: photoImageUrl, type: MessageTypeConst.photoMessage),
    );
  }

  void _sendVideoMessage() {
    StorageProviderRemoteDataSource.uploadMessageFile(
            file: _video!,
            onComplete: (isUploading) {},
            uid: widget.message.senderUid,
            otherUid: widget.message.recipientUid,
            type: MessageTypeConst.videoMessage)
        .then(
      (videoImageUrl) => _sendMessage(
          message: videoImageUrl, type: MessageTypeConst.videoMessage),
    );
  }

  Future<void> _sendGifMessage() async {}
  // Future<void> _sendGifMessage() async {
  //   final gif = await pickGIF(context);
  //   if (gif != null) {
  //     final constructedUrl =
  //         'https://media.giphy.com/media/${gif.id}/giphy.gif';
  //     _sendMessage(message: constructedUrl, type: MessageTypeConst.gifMessage);
  //   } else {
  //     // Handle GIF selection error (e.g., show a toast or snackbar)
  //     print('Failed to pick a GIF.'); // Or display a user-friendly message
  //   }
  // }

  void _sendMessage(
      {required String message,
      required String type,
      String? repliedMessage,
      String? repliedMessageType,
      String? repliedTo}) {
    _scrollToBottom();
    ChatUtiles.sendMessage(context,
            messageEntity: widget.message,
            message: message,
            repliedMessage: repliedMessage,
            repliedMessageType: repliedMessageType,
            repliedTo: repliedTo,
            type: type)
        .then(
      (value) {
        messageController.clear();
        _scrollToBottom();
      },
    );
  }
}
