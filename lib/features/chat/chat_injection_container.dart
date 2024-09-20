import 'package:whatsapp_clone/features/chat/data/data_sources/chat_remote_data_source.dart';
import 'package:whatsapp_clone/features/chat/data/data_sources/chat_remote_data_source_imp.dart';
import 'package:whatsapp_clone/features/chat/data/repository/chat_repository_imp.dart';
import 'package:whatsapp_clone/features/chat/domain/repository/chat_repository.dart';
import 'package:whatsapp_clone/features/chat/domain/usercases/delete_chat_usecase.dart';
import 'package:whatsapp_clone/features/chat/domain/usercases/delete_message_usecase.dart';
import 'package:whatsapp_clone/features/chat/domain/usercases/get_messages_usecase.dart';
import 'package:whatsapp_clone/features/chat/domain/usercases/get_my_chat_usecase.dart';
import 'package:whatsapp_clone/features/chat/domain/usercases/send_message_usecase.dart';
import 'package:whatsapp_clone/features/chat/presentation/cubit/chat/chat_cubit.dart';
import 'package:whatsapp_clone/features/chat/presentation/cubit/message/message_cubit.dart';
import 'package:whatsapp_clone/main_injection_container.dart';

Future<void> chatInjectionContainer() async {
//cubit
  sl.registerFactory<ChatCubit>(() =>
      ChatCubit(getMyChatUsecase: sl.call(), deleteChatUsecase: sl.call()));
  sl.registerFactory<MessageCubit>(() => MessageCubit(
      getMessagesUsecase: sl.call(),
      sendMessageUsecase: sl.call(),
      deleteMessageUsecase: sl.call()));
//useCases
  sl.registerLazySingleton<DeleteChatUsecase>(
    () => DeleteChatUsecase(chatRepository: sl.call()),
  );
  sl.registerLazySingleton<DeleteMessageUsecase>(
    () => DeleteMessageUsecase(chatRepository: sl.call()),
  );
  sl.registerLazySingleton<GetMessagesUsecase>(
    () => GetMessagesUsecase(chatRepository: sl.call()),
  );
  sl.registerLazySingleton<GetMyChatUsecase>(
    () => GetMyChatUsecase(chatRepository: sl.call()),
  );
  sl.registerLazySingleton<SendMessageUsecase>(
    () => SendMessageUsecase(chatRepository: sl.call()),
  );
//repository&DataSources
  sl.registerLazySingleton<ChatRepository>(
    () => ChatRepositoryImp(chatRemoteDataSource: sl.call()),
  );
  sl.registerLazySingleton<ChatRemoteDataSource>(
    () => ChatRemoteDataSourceImp(firestore: sl.call()),
  );
}
