import 'package:whatsapp_clone/features/user/data/data_sources/remote/user_remote_data_source.dart';
import 'package:whatsapp_clone/features/user/data/data_sources/remote/user_remote_data_source_imp.dart';
import 'package:whatsapp_clone/features/user/data/repository/user_repository_imp.dart';
import 'package:whatsapp_clone/features/user/domain/repository/user_repository.dart';
import 'package:whatsapp_clone/features/user/domain/usecases/credential/get_current_uid_usecase.dart';
import 'package:whatsapp_clone/features/user/domain/usecases/credential/is_sign_in_usecase.dart';
import 'package:whatsapp_clone/features/user/domain/usecases/credential/sign_in_with_phone_number_usecase.dart';
import 'package:whatsapp_clone/features/user/domain/usecases/credential/sign_out_usecase.dart';
import 'package:whatsapp_clone/features/user/domain/usecases/credential/verify_phone_number_usecase.dart';
import 'package:whatsapp_clone/features/user/domain/usecases/user/create_user_usecase.dart';
import 'package:whatsapp_clone/features/user/domain/usecases/user/get_all_users_usecase.dart';
import 'package:whatsapp_clone/features/user/domain/usecases/user/get_device_number_usecase.dart';
import 'package:whatsapp_clone/features/user/domain/usecases/user/get_single_user_usecase.dart';
import 'package:whatsapp_clone/features/user/domain/usecases/user/update_user_usecase.dart';
import 'package:whatsapp_clone/features/user/presentation/cubit/auth/cubit/auth_cubit.dart';
import 'package:whatsapp_clone/features/user/presentation/cubit/credential/cubit/credential_cubit.dart';
import 'package:whatsapp_clone/features/user/presentation/cubit/get_device_number/cubit/get_device_number_cubit.dart';
import 'package:whatsapp_clone/features/user/presentation/cubit/get_single_user/cubit/get_single_user_cubit.dart';
import 'package:whatsapp_clone/features/user/presentation/cubit/user/cubit/user_cubit.dart';
import 'package:whatsapp_clone/main_injection_container.dart';

Future<void> userInjectionContainer() async {
// Cubit injection
  sl.registerFactory<AuthCubit>(
    () => AuthCubit(
        getCurrentUIDUseCase: sl.call(),
        isSignInUseCase: sl.call(),
        signOutUseCase: sl.call()),
  );
  sl.registerFactory<CredentialCubit>(
    () => CredentialCubit(
        signInWithPhoneNumberUseCase: sl.call(),
        verifyPhoneNumberUseCase: sl.call(),
        createUserUseCase: sl.call()),
  );
  sl.registerFactory<GetDeviceNumberCubit>(
      () => GetDeviceNumberCubit(getDeviceNumberUseCase: sl.call()));
  sl.registerFactory<GetSingleUserCubit>(
    () => GetSingleUserCubit(getSingleUserUseCase: sl.call()),
  );
  sl.registerFactory<UserCubit>(
    () =>
        UserCubit(updateUserUseCase: sl.call(), getAllUsersUseCase: sl.call()),
  );

  // Use Cases Injection

  sl.registerLazySingleton<GetCurrentUIDUseCase>(
    () => GetCurrentUIDUseCase(repository: sl.call()),
  );
  sl.registerLazySingleton<IsSignInUseCase>(
    () => IsSignInUseCase(repository: sl.call()),
  );
  sl.registerLazySingleton<SignInWithPhoneNumberUseCase>(
    () => SignInWithPhoneNumberUseCase(repository: sl.call()),
  );
  sl.registerLazySingleton<SignOutUseCase>(
    () => SignOutUseCase(repository: sl.call()),
  );
  sl.registerLazySingleton<VerifyPhoneNumberUseCase>(
    () => VerifyPhoneNumberUseCase(repository: sl.call()),
  );
  sl.registerLazySingleton<CreateUserUseCase>(
    () => CreateUserUseCase(repository: sl.call()),
  );
  sl.registerLazySingleton<GetAllUsersUseCase>(
    () => GetAllUsersUseCase(repository: sl.call()),
  );
  sl.registerLazySingleton<GetDeviceNumberUseCase>(
    () => GetDeviceNumberUseCase(repository: sl.call()),
  );
  sl.registerLazySingleton<GetSingleUserUseCase>(
    () => GetSingleUserUseCase(repository: sl.call()),
  );
  sl.registerLazySingleton<UpdateUserUseCase>(
    () => UpdateUserUseCase(repository: sl.call()),
  );
  // Repository & Data Sources Injection
  sl.registerLazySingleton<UserRepository>(
    () => UserRepositoryImp(remoteDataSource: sl.call()),
  );
  sl.registerLazySingleton<UserRemoteDataSource>(
    () => UserRemoteDataSourceImp(auth: sl.call(), firestore: sl.call()),
  );
}
